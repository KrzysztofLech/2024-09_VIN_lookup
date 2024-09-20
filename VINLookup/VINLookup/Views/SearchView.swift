//  SearchView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct SearchView: View {
	@ObservedObject var viewModel: MainViewModel

    var body: some View {
		ScrollView {
			VINSearchView(
				vinNumber: $viewModel.vinNumber,
				isDataDownloading: $viewModel.isDataDownloading,
				searchAction: { vinNumber in
					viewModel.searchVIN(vinNumber)
				}
			)
			.padding(.top, 100)
			.padding(.horizontal, 32)
		}
		.scrollDisabled(true)
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
