//  VINLookupApp.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

@main
struct VINLookupApp: App {

    var body: some Scene {
        WindowGroup {
			let localDataService = LocalDataService()
			let mainViewModel = MainViewModel(localDataService: localDataService)
            MainView(viewModel: mainViewModel)
				.preferredColorScheme(.light)
        }
    }
}
