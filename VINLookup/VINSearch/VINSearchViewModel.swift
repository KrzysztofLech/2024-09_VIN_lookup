//  VINSearchViewModel.swift
//  Created by Krzysztof Lech on 23/09/2024.

import Foundation

final class VINSearchViewModel: ObservableObject {
	@Published var vinNumber: String = "JH4KA7561PC008269" // ""
	@Published var isDataDownloading: Bool = false
	@Published var showNetworkAlert: Bool = false
	@Published var vinData: VINData?

	private let remoteDataService: RemoteDataServiceProtocol

	init(remoteDataService: RemoteDataServiceProtocol = RemoteDataService()) {
		self.remoteDataService = remoteDataService
	}

	@MainActor
	func searchData() {
		Task {
			do {
				isDataDownloading = true
				vinData = try await remoteDataService.fetchVehicleData(forVIN: vinNumber)
				Logger.log(okText: "VIN: \(vinNumber) data downloaded!")

				vinNumber = ""
				isDataDownloading = false

			} catch {
				isDataDownloading = false
				if let error = error as? NetworkingError {
					Logger.log(error: error.errorDescription)
				}
				showNetworkAlert = true
			}
		}
	}
}
