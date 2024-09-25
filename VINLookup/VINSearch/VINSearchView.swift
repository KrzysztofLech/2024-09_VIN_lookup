//  VINSearchView.swift
//  Created by Krzysztof Lech on 23/09/2024.

import SwiftUI

public struct VINSearchView: View {

	@StateObject private var viewModel = VINSearchViewModel()

	@Binding private var selectedNumber: String
	private let searchCompletion: ((String) -> Void)?

	public init(selectedNumber: Binding<String>, searchCompletion: ((String) -> Void)? = nil) {
		self._selectedNumber = selectedNumber
		self.searchCompletion = searchCompletion
	}

	public var body: some View {
		VStack(spacing: 32) {
			VINInputView(
				vinNumber: $viewModel.vinNumber,
				isDataDownloading: $viewModel.isDataDownloading,
				isNumberValid: $viewModel.isNumberValid,
				searchAction: {
					viewModel.searchData(completion: searchCompletion)
				}
			)

			if let vinData = viewModel.vinData {
				VINDataView(data: vinData)
			}

			Spacer(minLength: 0)
		}
		.padding(.top, 32)
		.padding(.horizontal, 32)

		.ignoresSafeArea(.keyboard, edges: .bottom)

		.alert(isPresented: $viewModel.showAlert) {
			Alert(
				title: Text(viewModel.alertType.title),
				message: Text(viewModel.alertType.message),
				dismissButton: .default(Text(viewModel.alertType.buttonTitle))
			)
		}

		.onChange(of: selectedNumber) { _, newValue in
			viewModel.handleSelectedNumber(number: newValue)
		}
	}
}

#Preview {
	VINSearchView(selectedNumber: Binding.constant(""))
}
