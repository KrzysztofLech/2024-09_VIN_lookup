//  VINSearchView.swift
//  Created by Krzysztof Lech on 23/09/2024.

import SwiftUI

public struct VINSearchView: View {
	@StateObject var viewModel = VINSearchViewModel()

	public init() {}

	public var body: some View {
		VStack(spacing: 32) {
			VINInputView(
				vinNumber: $viewModel.vinNumber,
				isDataDownloading: $viewModel.isDataDownloading,
				searchAction: viewModel.searchData
			)

			if let vinData = viewModel.vinData {
				VINDataView(data: vinData)
			}

			Spacer(minLength: 0)
		}
		.padding(.top, 32)
		.padding(.horizontal, 32)

		.ignoresSafeArea(.keyboard, edges: .bottom)

		.alert(isPresented: $viewModel.showNetworkAlert) {
			Alert(title: Text(VINString.APIproblem.title),
				  message: Text(VINString.APIproblem.message),
				  dismissButton: .default(Text(VINString.APIproblem.buttonTitle))
			)
		}
	}
}

#Preview {
	VINSearchView()
}
