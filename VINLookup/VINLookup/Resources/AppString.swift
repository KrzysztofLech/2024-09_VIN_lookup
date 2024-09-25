//  AppString.swift
//  Created by Krzysztof Lech on 19/09/2024.

import Foundation

enum AppString {
	enum TabView {
		static let searchPageTitle = "Search"
		static let recentPageTitle = "Recent"
	}

	static let mainViewTitle = "VIN Lookup"

	static let noDataText = "No recent VIN numbers"

	enum OCR {
		static let title = "Correct the text:"
		static let noTextPlaceholder = "It was not possible to recognise any text."
		static let okButtonTitle = "OK"
		static let cancelButtonTitle = "Cancel"
	}
}
