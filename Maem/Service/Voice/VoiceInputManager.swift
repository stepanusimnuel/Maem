//
//  VoiceInputManager.swift
//  Maem
//

import Foundation
import SwiftUI
import AVFoundation
import Speech
import Observation

enum VoiceAuthStatus {
    case notDetermined
    case authorized
    case denied
    case unsupported
}

enum VoiceInputError: Error {
    case noCompatibleAudioFormat
}

@Observable
final class VoiceInputManager: NSObject {

    var isRecording: Bool = false
    var authorizationStatus: VoiceAuthStatus = .notDetermined
    var errorMessage: String?

    private let locale = Locale(identifier: "id-ID")
    private let audioEngine = AVAudioEngine()

    private var transcriber: SpeechTranscriber?
    private var analyzer: SpeechAnalyzer?
    private var inputContinuation: AsyncStream<AnalyzerInput>.Continuation?
    private var resultsTask: Task<Void, Never>?
    private var textBinding: Binding<String>?

    override init() {
        super.init()
        Task { await refreshSupportStatus() }
    }

    private func refreshSupportStatus() async {
        let supportedLocales = await SpeechTranscriber.supportedLocales
        let isSupported = supportedLocales
            .map { $0.identifier(.bcp47) }
            .contains(locale.identifier(.bcp47))

        guard !isSupported else { return }
        authorizationStatus = .unsupported
    }

    func requestAuthorization() async {
        guard authorizationStatus != .unsupported else { return }

        let micGranted = await AVAudioApplication.requestRecordPermission()

        let speechStatus = await withCheckedContinuation { (continuation: CheckedContinuation<SFSpeechRecognizerAuthorizationStatus, Never>) in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }

        switch (micGranted, speechStatus) {
        case (true, .authorized):
            authorizationStatus = .authorized
        case (_, .notDetermined):
            authorizationStatus = .notDetermined
        default:
            authorizationStatus = .denied
        }
    }

    func startRecording(into textBinding: Binding<String>) {
        guard !isRecording, authorizationStatus == .authorized else { return }

        self.textBinding = textBinding
        errorMessage = nil

        Task {
            do {
                try await ensureModelInstalled()
                try await beginTranscription()
            } catch {
                errorMessage = "Gagal memulai rekaman suara."
                finishRecording()
            }
        }
    }

    func stopRecording() {
        finishRecording()
    }

    private func ensureModelInstalled() async throws {
        let installedLocales = await SpeechTranscriber.installedLocales
        let alreadyInstalled = installedLocales
            .map { $0.identifier(.bcp47) }
            .contains(locale.identifier(.bcp47))

        guard !alreadyInstalled else { return }

        let probe = SpeechTranscriber(
            locale: locale,
            transcriptionOptions: [],
            reportingOptions: [.volatileResults],
            attributeOptions: []
        )

        guard let request = try await AssetInventory.assetInstallationRequest(supporting: [probe]) else {
            return
        }

        try await request.downloadAndInstall()
    }

    private func beginTranscription() async throws {
        let transcriber = SpeechTranscriber(
            locale: locale,
            transcriptionOptions: [],
            reportingOptions: [.volatileResults],
            attributeOptions: []
        )
        self.transcriber = transcriber

        let analyzer = SpeechAnalyzer(modules: [transcriber])
        self.analyzer = analyzer

        let (stream, continuation) = AsyncStream<AnalyzerInput>.makeStream()
        self.inputContinuation = continuation

        guard let analyzerFormat = await SpeechAnalyzer.bestAvailableAudioFormat(compatibleWith: [transcriber]) else {
            throw VoiceInputError.noCompatibleAudioFormat
        }

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        let converter = AVAudioConverter(from: recordingFormat, to: analyzerFormat)
        let sampleRateRatio = analyzerFormat.sampleRate / recordingFormat.sampleRate

        // Runs on an audio-render thread, not MainActor — only touches local
        // captures (converter, analyzerFormat, sampleRateRatio, continuation),
        // never `self`, so it needs no isolation hop.
        inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { buffer, _ in
            guard let converter else { return }

            let capacity = AVAudioFrameCount(Double(buffer.frameLength) * sampleRateRatio) + 1024
            guard let converted = AVAudioPCMBuffer(pcmFormat: analyzerFormat, frameCapacity: capacity) else { return }

            var conversionError: NSError?
            converter.convert(to: converted, error: &conversionError) { _, inputStatus in
                inputStatus.pointee = .haveData
                return buffer
            }

            guard conversionError == nil else { return }
            continuation.yield(AnalyzerInput(buffer: converted))
        }

        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .measurement, options: .duckOthers)
        try session.setActive(true, options: .notifyOthersOnDeactivation)

        audioEngine.prepare()
        try audioEngine.start()

        try await analyzer.start(inputSequence: stream)

        isRecording = true

        resultsTask = Task {
            do {
                for try await result in transcriber.results {
                    textBinding?.wrappedValue = String(result.text.characters)

                    if result.isFinal {
                        break
                    }
                }
            } catch is CancellationError {
                return
            } catch {
                errorMessage = "Gagal memproses suara."
            }

            finishRecording()
        }
    }

    private func finishRecording() {
        guard isRecording else { return }

        resultsTask?.cancel()
        resultsTask = nil

        audioEngine.inputNode.removeTap(onBus: 0)
        if audioEngine.isRunning {
            audioEngine.stop()
        }

        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        inputContinuation?.finish()
        inputContinuation = nil
        textBinding = nil
        transcriber = nil
        analyzer = nil

        isRecording = false
    }

}
