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
		TabView {
			Group {
				VINSearchView()
					.tabItem {
						Image(systemName: "magnifyingglass")
						Text(AppString.TabView.searchPageTitle)
					}

				RecentView()
					.tabItem {
						Image(systemName: "list.bullet")
						Text(AppString.TabView.recentPageTitle)
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
	MainView(viewModel: MainViewModel())
}
