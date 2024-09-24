//  MainViewModel.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

final class MainViewModel: ObservableObject {

	private var localDataService: LocalDataServiceProtocol

	@Published var selectedTabIndex: Int = 0
	@Published var vinNumbers: [String] = []
	@Published var selectedNumber: String = ""

	init(localDataService: LocalDataServiceProtocol) {
		self.localDataService = localDataService
		vinNumbers = localDataService.vinNumbers
	}

	func handleNumber(_ number: String) {
		if let index = vinNumbers.firstIndex(of: number) {
			vinNumbers.remove(at: index)
		}

		vinNumbers.insert(number, at: 0)
		localDataService.vinNumbers = vinNumbers
	}

	func onSelect(number: String) {
		selectedNumber = number
		selectedTabIndex = 0
	}
}
