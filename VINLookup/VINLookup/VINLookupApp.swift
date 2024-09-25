//  VINLookupApp.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

@main
struct VINLookupApp: App {

    var body: some Scene {
        WindowGroup {
			let localDataService: LocalDataServiceProtocol = LocalDataService()
			let textRecognitionService: TextRecognitionServiceProtocol = TextRecognitionService()

			let mainViewModel = MainViewModel(
				localDataService: localDataService,
				textRecognitionService: textRecognitionService
			)
            MainView(viewModel: mainViewModel)
				.preferredColorScheme(.light)
        }
    }
}
