//  LocalDataService.swift
//  Created by Krzysztof Lech on 24/09/2024.

import Foundation
import Utils

protocol LocalDataServiceProtocol {
	var vinNumbers: [String] { get set }
}

struct LocalDataService: LocalDataServiceProtocol {

	private let fileURL: URL

	init(fileURL: URL =  LocalDataService.defaultFileURL()) {
		self.fileURL = fileURL
	}

	private static func defaultFileURL() -> URL {
		FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
			.appendingPathComponent("numbers.txt")
	}

	var vinNumbers: [String] {
		get {
			do {
				let data = try Data(contentsOf: fileURL)
				let numbers = (try JSONSerialization.jsonObject(with: data, options: []) as? [String]) ?? []
				Logger.log(okText: "Recent VIN numbers read! \(numbers.count) items")
				return numbers
			} catch {
				Logger.log(error: "Error loading Recent VIN numbers: \(error)")
				return []
			}
		}
		set {
			do {
				let data = try JSONSerialization.data(withJSONObject: newValue, options: [])
				try data.write(to: fileURL)
				Logger.log(okText: "Recent VIN numbers saved! \(newValue.count) items")
			} catch {
				Logger.log(error: "Error saving Recent VIN numbers: \(error)")
			}
		}
	}
}
