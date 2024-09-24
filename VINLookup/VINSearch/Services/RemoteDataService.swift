//  RemoteDataService.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation
import Utils

protocol URLSessionProtocol {
	func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol RemoteDataServiceProtocol {
	func fetchVehicleData(forVIN vinNumber: String) async throws -> VINData
}

final class RemoteDataService: RemoteDataServiceProtocol {
	private let session: URLSessionProtocol
	private let apiKey = "j1cotrZRdNwKls1HS5z9wA==f6dzxqIggVWtTDyn"
	private let apiUrlString = "https://api.api-ninjas.com/v1/vinlookup"

	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}

	func fetchVehicleData(forVIN vinNumber: String) async throws -> VINData {
		guard
			let encodedString = vinNumber.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			let urlRequest = getUrlRequest(vinNumber: encodedString)
		else {
			throw NetworkingError.invalidRequest
		}

		Logger.log(info: "Request: \(urlRequest)")

		guard
			let (data, _) = try? await session.data(for: urlRequest)
		else {
			throw NetworkingError.invalidResponse
		}

		do {
			return try JSONDecoder().decode(VINData.self, from: data)
		} catch {
			if let decodingError = error as? DecodingError {
				throw NetworkingError.parseJSON(decodingError)
			}
			throw NetworkingError.unknown(error)
		}
	}

	private func getUrlRequest(vinNumber: String) -> URLRequest? {
		var urlComponents = URLComponents(string: apiUrlString)
		urlComponents?.queryItems = [
			URLQueryItem(name: "vin", value: vinNumber)
		]

		guard let url = urlComponents?.url else { return nil }

		var urlRequest = URLRequest(url: url)
		urlRequest.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

		return urlRequest
	}
}
