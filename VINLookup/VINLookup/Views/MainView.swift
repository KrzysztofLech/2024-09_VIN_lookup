//  MainView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct MainView: View {

	@ObservedObject var viewModel: MainViewModel

	var body: some View {
		NavigationView {
			tabView
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle(Strings.mainViewTitle)
		}
	}

	private var tabView: some View {
		TabView {
			Group {
				SearchView(viewModel: viewModel)
					.tabItem {
						Image(systemName: "magnifyingglass")
						Text(Strings.TabView.searchPageTitle)
					}

				RecentView()
					.tabItem {
						Image(systemName: "list.bullet")
						Text(Strings.TabView.recentPageTitle)
					}
			}
			.toolbarBackground(.visible, for: .navigationBar)
			.toolbarBackground(.visible, for: .tabBar)

			.toolbarBackground(Color.theme1, for: .navigationBar)
			.toolbarBackground(Color.theme1, for: .tabBar)

			.toolbarColorScheme(.dark, for: .navigationBar)
		}
	}
}

#Preview {
	MainView(
		viewModel: MainViewModel(
			dataService: DataService(
				remoteDataService: RemoteDataService()
			)
		)
	)
}
