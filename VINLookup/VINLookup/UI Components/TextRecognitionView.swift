//  TextRecognitionView.swift
//  Created by Krzysztof Lech on 25/09/2024.

import SwiftUI

struct TextRecognitionView: View {

	@ObservedObject var viewModel: MainViewModel
	@State private var showProgressIndicator: Bool = false
	@State private var recognisedText: String = ""

	var body: some View {
		ZStack {
			Rectangle()
				.ignoresSafeArea()
				.background(.ultraThinMaterial)

			closeButton

			if showProgressIndicator {
				ProgressView()
					.tint(.light)
					.scaleEffect(2)
			} else {
				Group {
					if recognisedText.isEmpty {
						noTextInfo
							.frame(width: 300, height: 200, alignment: .center)
					} else {
						textEdit
							.frame(width: 300, height: 400, alignment: .center)
					}
				}
				.background {
					Color.theme1
						.cornerRadius(12)
						.shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
				}
			}
		}
		.onAppear {
			startTextRecognition()
		}
	}

	private var closeButton: some View {
		VStack(alignment: .trailing, spacing: 0) {
			HStack {
				Spacer()
				Button(
					action: close,
					label: {
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.light)
							.scaleEffect(2)
					}
				)
				.padding(16)
			}
			Spacer()
		}
	}

	private var noTextInfo: some View {
		VStack(spacing: 32) {
			Text(AppString.OCR.noTextPlaceholder)
				.multilineTextAlignment(.center)
				.font(.system(size: 24, weight: .semibold))
				.foregroundColor(.light)

			buttonWithText(
				action: {
					close()
				},
				text: AppString.OCR.cancelButtonTitle
			)
		}
	}

	private var textEdit: some View {
		VStack(alignment: .center, spacing: 16) {
			Text(AppString.OCR.title)
				.foregroundStyle(Color.light)
				.font(.system(size: 20, weight: .semibold))

			TextEditor(text: $recognisedText)
				.font(.system(size: 22))
				.padding(4)
				.background(Color.light)

			buttonWithText(
				action: {
					viewModel.assignRecognisedNumber(recognisedText)
					close()
				},
				text: AppString.OCR.okButtonTitle
			)
		}
		.padding(.vertical, 16)
	}

	private func buttonWithText(action: @escaping () -> Void, text: String) -> some View {
		Button(
			action: action,
			label: {
				Text(text)
					.foregroundStyle(Color.theme2)
					.font(.system(size: 20, weight: .semibold))
					.padding(.horizontal, 32)
					.frame(height: 50)
					.background(Color.theme3)

			}
		)
		.cornerRadius(8)

	}

	private func startTextRecognition() {
		showProgressIndicator = true
		viewModel.recogniseTextFromCameraPickerPhoto { text in
			if let text {
				recognisedText = text
				showProgressIndicator = false
			} else {
				close()
			}
		}
	}

	private func close() {
		viewModel.isRecognising = false
	}
}

#Preview {
	TextRecognitionView(viewModel: MainViewModel(localDataService: LocalDataService(), textRecognitionService: TextRecognitionService()))
}
