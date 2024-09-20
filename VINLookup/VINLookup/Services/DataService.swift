//  DataService.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

protocol DataServiceProtocol {
	func searchVIN(vinText: String) async throws -> VINData
}

final class DataService: DataServiceProtocol {
	private let remoteDataService: RemoteDataServiceProtocol

	init(remoteDataService: RemoteDataServiceProtocol) {
		self.remoteDataService = remoteDataService
	}

	func searchVIN(vinText: String) async throws -> VINData {
		let encodedString = vinText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
		return try await remoteDataService.getVIN(encodedString)
	}
}
