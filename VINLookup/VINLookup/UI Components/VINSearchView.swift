//  VINSearchView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct VINSearchView: View {
	@Binding var vinNumber: String
	@Binding var isDataDownloading: Bool
	let searchAction: (String) -> Void

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
			Color.theme1
				.cornerRadius(12)
				.shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
		}
	}

	private var textField: some View {
		TextField(
			"",
			text: $vinNumber,
			prompt: Text(Strings.SearchComponent.prompt)
		)
		.multilineTextAlignment(.center)
		.font(.system(size: 24))
		.foregroundColor(.theme2)
		.tint(.theme2)

		.frame(height: 48)
		.background(.light)
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
			.tint(.light)
			.scaleEffect(1.5)
			.frame(height: 50)
			.padding(.bottom, 32)
	}

	private var searchButton: some View {
		Button(
			action: {
				searchAction(vinNumber)
			},
			label: {
				Text(Strings.SearchComponent.buttonTitle)
					.foregroundStyle(Color.theme2)
					.font(.system(size: 20, weight: .semibold))
					.padding(.horizontal, 32)
					.frame(height: 50)
					.background(Color.theme3)
			}
		)
		.cornerRadius(8)
		.padding(.bottom, 32)
	}
}

#Preview {
	SearchView(
		viewModel: MainViewModel(
			dataService: DataService(
				remoteDataService: RemoteDataService()
			)
		)
	)
}
