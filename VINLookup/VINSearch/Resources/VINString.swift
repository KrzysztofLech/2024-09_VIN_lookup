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

	enum LimitReached {
		static let title = "The request rate limit has been reached!"
		static let message = "Try again in a minute"
		static let buttonTitle = "OK"
	}

	enum Data {
		static let premiumDataPrefix = "Only"
		static let premiumTitle = "PREMIUM"
	}
}
