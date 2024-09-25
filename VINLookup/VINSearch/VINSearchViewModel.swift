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
	@Published var vinData: VINData?

	@Published var showAlert: Bool = false
	var alertType: AlertType = .none

	private let numberCharacters: Int = 17
	private var timer: Timer?
	private let timeInterval: TimeInterval = 60
	private let maxRequestsPerMinute: Int = 10
	private var requestsCounter: Int = 0

	private let remoteDataService: RemoteDataServiceProtocol

	init(remoteDataService: RemoteDataServiceProtocol = RemoteDataService()) {
		self.remoteDataService = remoteDataService
	}

	@MainActor
	func searchData(completion: ((String) -> Void)?) {
		guard requestsCounter < maxRequestsPerMinute else {
			Logger.log(error: "The request rate limit has been reached!")
			alertType = .limitReached
			showAlert = true
			return
		}

		vinData = nil
		requestsCounter += 1
		startTimerIfNeeded()

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
				alertType = .apiProblem
				showAlert = true
			}
		}
	}

	private func startTimerIfNeeded() {
		guard timer == nil else { return }

		Logger.log(info: "Timer started")
		timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
			self?.requestsCounter = 0
			self?.timer = nil
			Logger.log(info: "Timer stopped")
		}
	}

	func handleSelectedNumber(number: String) {
		vinData = nil
		vinNumber = number
	}

	private func validateNumber() {
		isNumberValid = vinNumber.count == numberCharacters && vinNumber.range(of: ".*[^a-zA-Z0-9].*", options: .regularExpression) == nil
	}
}
