//  MainViewModel.swift
//  Created by Krzysztof Lech on 20/09/2024.

import UIKit
import Utils

final class MainViewModel: ObservableObject {

	private var localDataService: LocalDataServiceProtocol
	private let textRecognitionService: TextRecognitionServiceProtocol

	@Published var selectedTabIndex: Int = 0
	@Published var vinNumbers: [String] = []
	@Published var selectedNumber: String = ""

	@Published var isCameraPickerPresented = false
	@Published var cameraPickerSelectedPhoto: UIImage?
	@Published var isRecognising = false

	init(localDataService: LocalDataServiceProtocol, textRecognitionService: TextRecognitionServiceProtocol) {
		self.localDataService = localDataService
		self.textRecognitionService = textRecognitionService
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

	func showCameraPicker() {
		isCameraPickerPresented = true
	}

	func startTextRecognition() {
		guard cameraPickerSelectedPhoto != nil else { return }
		isRecognising = true
	}

	func recogniseTextFromCameraPickerPhoto(completion: @escaping (String?) -> Void) {
		guard let image = cameraPickerSelectedPhoto else {
			completion(nil)
			return
		}

		textRecognitionService.recogniseTextFromImage(image) { recognisedText in
			DispatchQueue.main.async {
				if let recognisedText, !recognisedText.isEmpty {
					Logger.log(info: "Recognised text:\n\(recognisedText)")
				} else {
					Logger.log(error: "No recognised text!")
				}

				let filteredText = recognisedText?.replacingOccurrences(
					of: "\\s+",
					with: "",
					options: .regularExpression
				)
				completion(filteredText)
			}
		}
	}

	func assignRecognisedNumber(_ number: String) {
		selectedNumber = number
		selectedTabIndex = 0
	}
}
