//  MainViewModel.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

final class MainViewModel: ObservableObject {

	@Published var vinNumber: String = "JH4KA7561PC008269" // ""
	@Published var selectedTabIndex: Int = 0
	@Published var vinNumbers: [String] = ["JH4KA7561PC008269", "AB4KA7561PC008123"] //[]

	func handle(vinNumber: String) {
		vinNumbers.append(vinNumber)
	}

	func onSelect(number: String) {
		vinNumber = number
		selectedTabIndex = 0
	}
}
