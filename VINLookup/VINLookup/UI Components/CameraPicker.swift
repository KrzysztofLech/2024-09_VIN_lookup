//  CameraPicker.swift
//  Created by Krzysztof Lech on 25/09/2024.

import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
	var sourceType: UIImagePickerController.SourceType = .camera
	@Binding var photo: UIImage?
	@Environment(\.dismiss) private var dismiss

	func makeUIViewController(context: Context) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator
		return imagePicker
	}

	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

	func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}

	class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		let parent: CameraPicker

		init(parent: CameraPicker) {
			self.parent = parent
		}

		func imagePickerController(
			_ picker: UIImagePickerController,
			didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
		) {
			guard let image = info[.originalImage] as? UIImage else { return }
			parent.photo = image
			parent.dismiss()
		}
	}
}
