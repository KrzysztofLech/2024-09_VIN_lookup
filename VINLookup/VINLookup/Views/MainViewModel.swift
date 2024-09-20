//  MainViewModel.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

final class MainViewModel: ObservableObject {

	@Published var vinNumber: String = "JH4KA7561PC008269"
	@Published var isDataDownloading: Bool = false
	@Published var vinData: VINData?

	private let dataService: DataServiceProtocol

	init(dataService: DataServiceProtocol) {
		self.dataService = dataService
	}

	@MainActor
	func searchData() {
		Task {
			do {
				isDataDownloading = true
				vinData = try await dataService.getVehicleData(forVIN: vinNumber)
				Logger.log(okText: "VIN: \(vinNumber) data downloaded!")

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
