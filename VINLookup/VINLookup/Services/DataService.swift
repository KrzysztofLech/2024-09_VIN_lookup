//  DataService.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

protocol DataServiceProtocol {
	func getVehicleData(forVIN vinNumber: String) async throws -> VINData
}

final class DataService: DataServiceProtocol {
	private let remoteDataService: RemoteDataServiceProtocol

	init(remoteDataService: RemoteDataServiceProtocol) {
		self.remoteDataService = remoteDataService
	}

	func getVehicleData(forVIN vinNumber: String) async throws -> VINData {
		try await remoteDataService.fetchVehicleData(forVIN: vinNumber)
	}
}
