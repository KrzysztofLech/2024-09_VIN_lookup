//  MainView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI
import VINSearch

struct MainView: View {

	@ObservedObject var viewModel: MainViewModel

	var body: some View {
		NavigationView {
			tabView
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle(AppString.mainViewTitle)
		}
	}

	private var tabView: some View {
		TabView(selection: $viewModel.selectedTabIndex) {
			Group {
				VINSearchView(selectedNumber: $viewModel.selectedNumber, searchCompletion: { vinNumber in
					viewModel.handleNumber(vinNumber)
				})
				.tabItem {
					Image(systemName: "magnifyingglass")
					Text(AppString.TabView.searchPageTitle)
				}
				.tag(0)

				RecentView(vinNumbers: $viewModel.vinNumbers, onSelectAction: { vinNumber in
					viewModel.onSelect(number: vinNumber)
				})
				.tabItem {
					Image(systemName: "list.bullet")
					Text(AppString.TabView.recentPageTitle)
				}
				.tag(1)
			}
			.toolbarBackground(.visible, for: .navigationBar)
			.toolbarBackground(.visible, for: .tabBar)

			.toolbarBackground(Color.theme1, for: .navigationBar)
			.toolbarBackground(Color.theme1, for: .tabBar)

			.toolbarColorScheme(.dark, for: .navigationBar)
		}
		.tint(.white)
	}
}

#Preview {
	MainView(viewModel: MainViewModel(localDataService: LocalDataService()))
}
