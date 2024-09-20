//  VINLookupApp.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

@main
struct VINLookupApp: App {

    var body: some Scene {
        WindowGroup {
			let remoteDataService = RemoteDataService()
			let dataService = DataService(remoteDataService: remoteDataService)
			let mainViewModel = MainViewModel(dataService: dataService)

            MainView(viewModel: mainViewModel)
				.preferredColorScheme(.light)
        }
    }
}
