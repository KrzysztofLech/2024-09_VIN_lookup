//  MainViewModel.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

final class MainViewModel: ObservableObject {

	@Published var vinNumber: String = "JH4KA7561PC008269"
	@Published var isDataDownloading: Bool = false

	private let dataService: DataServiceProtocol

	init(dataService: DataServiceProtocol) {
		self.dataService = dataService
	}

	@MainActor
	func searchVIN(_ vinText: String) {
		Task {
			do {
				isDataDownloading = true
				let data = try await dataService.searchVIN(vinText: vinNumber)
				print("📺", data)
					vinNumber = ""
					isDataDownloading = false
			} catch {
				isDataDownloading = false
				if let error = error as? NetworkingError {
					Logger.log(error: error.errorDescription)
				}
			}
		}
	}
}
