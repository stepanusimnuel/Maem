//
//  SearchHeader.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import UIKit

struct SearchHeader: View {

    @Binding var searchText: String

    var isEditable: Bool = true

    let onTap: (() -> Void)?

    let onSearch: () -> Void

    @State private var voiceInput = VoiceInputManager()
    @State private var showPermissionAlert = false
    
    @FocusState private var isTextFieldFocused: Bool


    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            HStack(spacing: 8) {

                Image(systemName: "magnifyingglass")
                    .font(AppFont.headline(weight: .medium))

                if isEditable {

                    // TextField's .foregroundStyle colors the placeholder AND the
                    // typed text the same - overlaying a separately-styled
                    // placeholder is the only way to keep the placeholder muted
                    // while typed input stays clearly legible.
                    ZStack(alignment: .leading) {

                        if searchText.isEmpty {
                            Text("makanan untuk anak radang")
                                .font(AppFont.caption(weight: .medium))
                                .foregroundStyle(AppColor.neutralMedGrey)
                        }

                        TextField(
                            "",
                            text: $searchText
                        )
                        .font(AppFont.caption(weight: .medium))
                        .foregroundStyle(AppColor.neutralBlack)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            onSearch()
                        }

                    }

                    if voiceInput.authorizationStatus != .unsupported {
                        micButton
                    }

                } else {

                    Text(searchText.isEmpty
                         ? "makanan untuk anak radang"
                         : searchText)
                        .font(AppFont.caption(weight: .medium))
                        .foregroundStyle(searchText.isEmpty ? AppColor.neutralMedGrey : AppColor.neutralBlack)

                    Spacer()
                }

            }
            .padding()
            .frame(height: 48)
            .overlay(
                Capsule()
                    .stroke(
                        LinearGradient(
                            colors: [AppColor.red700, AppColor.blue500],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .background(AppColor.neutralWhite)
            .glassEffect(.clear)
            .shadow(
                color: Color.blue500.opacity(0.12),
                radius: 16,
                x: 0,
                y: 8
            )
            .contentShape(Rectangle())
            .onTapGesture {

                guard !isEditable else { return }

                onTap?()

            }
            .onChange(of: voiceInput.isRecording) { wasRecording, isRecordingNow in
                guard wasRecording, !isRecordingNow else { return }
                guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
            }
            .alert("Izin Mikrofon Diperlukan", isPresented: $showPermissionAlert) {
                Button("Buka Pengaturan") {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    UIApplication.shared.open(url)
                }
                Button("Batal", role: .cancel) {}
            } message: {
                Text("Aktifkan akses mikrofon dan pengenalan suara di Pengaturan untuk memakai pencarian suara.")
            }

            // Transient, non-modal — covers the "model download failed" /
            // "interrupted mid-recording" error-handling cases from the spec.
            // Clears itself next time recording starts (see VoiceInputManager.startRecording).
            if let errorMessage = voiceInput.errorMessage {
                Text(errorMessage)
                    .font(AppFont.caption(weight: .medium))
                    .foregroundStyle(AppColor.red700)
                    .padding(.horizontal, 4)
            }

        }
    }

    private var micButton: some View {
        Button {
            handleMicTap()
        } label: {
            Image(systemName: voiceInput.isRecording ? "mic.fill" : "mic")
                .font(AppFont.headline(weight: .medium))
                .foregroundStyle(micIconColor)
        }
        .frame(minWidth: 44, minHeight: 44)
        .contentShape(Rectangle())
        .buttonStyle(.plain)
        .accessibilityLabel(voiceInput.isRecording ? "Berhenti merekam" : "Cari dengan suara")
    }

    private var micIconColor: Color {
        if voiceInput.isRecording {
            AppColor.red700
        } else if voiceInput.authorizationStatus == .denied {
            AppColor.neutralMedGrey
        } else {
            AppColor.neutralBlack
        }
    }

    private func handleMicTap() {

        if voiceInput.isRecording {
            voiceInput.stopRecording()
            return
        }

        switch voiceInput.authorizationStatus {

        case .authorized:
            DispatchQueue.main.async {
                isTextFieldFocused = true
            }
            voiceInput.startRecording(into: $searchText)

        case .denied:
            showPermissionAlert = true

        case .notDetermined:
            Task {
                await voiceInput.requestAuthorization()
                if voiceInput.authorizationStatus == .authorized {
                    await MainActor.run {
                        isTextFieldFocused = true
                    }
                    voiceInput.startRecording(into: $searchText)
                } else if voiceInput.authorizationStatus == .denied {
                    showPermissionAlert = true
                }
            }

        case .unsupported:
            break

        }

    }

}

#Preview {
    NavigationStack {
        SearchHeader(searchText: .constant("Hello"), onTap: {}, onSearch: {})
    }
}
