//  VINSearchView.swift
//  Created by Krzysztof Lech on 23/09/2024.

import SwiftUI

public struct VINSearchView: View {
	@StateObject var viewModel = VINSearchViewModel()

	public init() {}

    public var body: some View {
		ScrollView {
			VINInputView(
				vinNumber: $viewModel.vinNumber,
				isDataDownloading: $viewModel.isDataDownloading,
				searchAction: viewModel.searchData
			)
			.padding(.top, 100)
			.padding(.horizontal, 32)
		}
		.scrollDisabled(true)
    }
}

#Preview {
    VINSearchView()
}
