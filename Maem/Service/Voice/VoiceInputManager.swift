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

@Observable
final class VoiceInputManager: NSObject {

    var isRecording: Bool = false
    var authorizationStatus: VoiceAuthStatus = .notDetermined
    var errorMessage: String?

    // SpeechAnalyzer/SpeechTranscriber (iOS 26's new on-device engine) does not
    // support Indonesian yet - confirmed on real hardware, not just docs, via
    // SpeechTranscriber.supportedLocales returning a list without "id-ID".
    // SFSpeechRecognizer (this older framework) has supported Indonesian for
    // years, and still uses on-device recognition when the locale/device
    // combination supports it (checked below via supportsOnDeviceRecognition).
    private let locale = Locale(identifier: "id-ID")
    private let speechRecognizer: SFSpeechRecognizer?
    private let audioEngine = AVAudioEngine()

    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var textBinding: Binding<String>?
    private var isStoppingManually = false

    override init() {
        let recognizer = SFSpeechRecognizer(locale: locale)
        self.speechRecognizer = recognizer
        super.init()

        guard let recognizer, recognizer.isAvailable else {
            authorizationStatus = .unsupported
            return
        }
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
        guard !isRecording, authorizationStatus == .authorized, let speechRecognizer else { return }

        self.textBinding = textBinding
        errorMessage = nil
        isStoppingManually = false

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        if speechRecognizer.supportsOnDeviceRecognition {
            request.requiresOnDeviceRecognition = true
        }
        recognitionRequest = request

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }

        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .measurement, options: .duckOthers)
            try session.setActive(true, options: .notifyOthersOnDeactivation)

            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            errorMessage = "Gagal memulai rekaman suara."
            finishRecording()
            return
        }

        isRecording = true

        recognitionTask = speechRecognizer.recognitionTask(with: request) { [weak self] result, error in
            // SFSpeechRecognitionTask's handler isn't guaranteed to run on the
            // main thread - hop explicitly since this type is MainActor-isolated.
            Task { @MainActor in
                guard let self else { return }

                if let result {
                    self.textBinding?.wrappedValue = result.bestTranscription.formattedString

                    if result.isFinal {
                        self.finishRecording()
                    }
                }

                if error != nil {
                    if !self.isStoppingManually {
                        self.errorMessage = "Gagal memproses suara."
                    }
                    self.finishRecording()
                }
            }
        }
    }

    func stopRecording() {
        guard isRecording else { return }

        isStoppingManually = true
        stopAudioCapture()
        recognitionRequest?.endAudio()
    }

    private func stopAudioCapture() {
        audioEngine.inputNode.removeTap(onBus: 0)
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    private func finishRecording() {
        guard isRecording else { return }

        stopAudioCapture()

        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest = nil
        textBinding = nil
        isStoppingManually = false

        isRecording = false
    }

}
