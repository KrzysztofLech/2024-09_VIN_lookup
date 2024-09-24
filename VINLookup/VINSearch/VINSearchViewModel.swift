//  VINSearchViewModel.swift
//  Created by Krzysztof Lech on 23/09/2024.

import Foundation
import Utils

final class VINSearchViewModel: ObservableObject {
	@Published var vinNumber: String = "" {
		didSet { validateNumber() }
	}

	@Published var isDataDownloading: Bool = false
	@Published var isNumberValid: Bool = false
	@Published var showNetworkAlert: Bool = false
	@Published var vinData: VINData?

	private let remoteDataService: RemoteDataServiceProtocol

	init(remoteDataService: RemoteDataServiceProtocol = RemoteDataService()) {
		self.remoteDataService = remoteDataService
	}

	@MainActor
	func searchData(completion: ((String) -> Void)?) {
		vinData = nil

		Task {
			do {
				isDataDownloading = true
				vinData = try await remoteDataService.fetchVehicleData(forVIN: vinNumber)
				completion?(vinNumber)
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

	func handleSelectedNumber(number: String) {
		vinData = nil
		vinNumber = number
	}

	private func validateNumber() {
		isNumberValid = vinNumber.count == 17 && vinNumber.range(of: ".*[^a-zA-Z0-9].*", options: .regularExpression) == nil
	}
}
