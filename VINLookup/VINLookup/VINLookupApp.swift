//  VINLookupApp.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

@main
struct VINLookupApp: App {

    var body: some Scene {
        WindowGroup {
			let mainViewModel = MainViewModel()
            MainView(viewModel: mainViewModel)
				.preferredColorScheme(.light)
        }
    }
}
