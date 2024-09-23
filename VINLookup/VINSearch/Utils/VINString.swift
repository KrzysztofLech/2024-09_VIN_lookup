//  VINString.swift
//  Created by Krzysztof Lech on 23/09/2024.

import Foundation

enum VINString {
	enum Input {
		static let prompt = "Type VIN"
		static let buttonTitle = "Search"
	}

	enum APIproblem {
		static let title = "Error!"
		static let message = "Sorry, there was a problem accessing the data"
		static let buttonTitle = "OK"
	}
}
