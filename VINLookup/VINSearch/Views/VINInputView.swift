//  VINInputView.swift
//  Created by Krzysztof Lech on 23/09/2024.

import SwiftUI

struct VINInputView: View {
	@Binding var vinNumber: String
	@Binding var isDataDownloading: Bool
	let searchAction: () -> Void

	var body: some View {
		VStack(spacing: 0) {
			textField

			Group {
				if isDataDownloading {
					progressView
				} else {
					searchButton
				}
			}
		}
		.background {
			VINColor.theme1
				.cornerRadius(12)
				.shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
		}
	}

	private var textField: some View {
		TextField(
			"",
			text: $vinNumber,
			prompt: Text(VINString.Input.prompt)
		)
		.multilineTextAlignment(.center)
		.font(.system(size: 22))
		.foregroundColor(VINColor.theme2)
		.tint(VINColor.theme2)

		.frame(height: 48)
		.background(VINColor.light)
		.cornerRadius(8)
		.padding(32)

		.autocorrectionDisabled()
		.keyboardType(.asciiCapable)
		.onChange(of: vinNumber, { _, newValue in
			vinNumber = newValue.uppercased()
		})

		.disabled(isDataDownloading)
	}

	private var progressView: some View {
		ProgressView()
			.tint(VINColor.light)
			.scaleEffect(1.5)
			.frame(height: 50)
			.padding(.bottom, 32)
	}

	private var searchButton: some View {
		Button(
			action: searchAction,
			label: {
				Text(VINString.Input.buttonTitle)
					.foregroundStyle(VINColor.theme2)
					.font(.system(size: 20, weight: .semibold))
					.padding(.horizontal, 32)
					.frame(height: 50)
					.background(VINColor.theme3)
			}
		)
		.cornerRadius(8)
		.padding(.bottom, 32)
	}
}

#Preview {
	VINSearchView(selectedNumber: Binding.constant(""))
}

