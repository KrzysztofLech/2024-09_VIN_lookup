//  VINData.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

struct VINData: Decodable {
	let vin: String
	let country: String
	let manufacturer: String
	let model: String
	let `class`: String
	let region: String
	let wmi: String
	let vds: String
	let vis: String
	private let year: Int?
}

extension VINData {
	var yearString: String {
		if let year {
			return String(year)
		} else {
			return "no data"
		}
	}
}

extension VINData {
	static let exampleVIN = VINData(
		vin: "JH4KA7561PC008269",
		country: "Japan",
		manufacturer: "Only",
		model: "Legend",
		class: "Sedan/Saloon",
		region: "Asia",
		wmi: "JH4",
		vds: "KA7561",
		vis: "PC008269",
		year: 1993
	)
}
