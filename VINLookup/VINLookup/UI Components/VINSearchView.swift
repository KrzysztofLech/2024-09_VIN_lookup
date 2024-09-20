//  VINSearchView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct VINSearchView: View {
	@State var vinNumber: String = ""

    var body: some View {
		VStack(spacing: 0) {
			TextField(
				"",
				text: $vinNumber,
				prompt: Text(Strings.SearchComponent.prompt)
			)
			.multilineTextAlignment(.center)
			.font(.system(size: 24))
			.foregroundColor(.text)
			
			.frame(height: 48)
			.background(.light)
			.cornerRadius(8)
			.padding(32)

			.autocorrectionDisabled()
			.keyboardType(.asciiCapable)
			.onChange(of: vinNumber, { _, newValue in
				vinNumber = newValue.uppercased()
			})

			Button(
				action: {},
				label: {
					Text(Strings.SearchComponent.buttonTitle)
						.font(.system(size: 22))
						.padding(.horizontal, 32)
						.frame(height: 50)
						.background(Color.light.opacity(0.3))
				}
			)
			.cornerRadius(8)
			.padding(.bottom, 32)

		}
		.background {
			Color.theme1
				.cornerRadius(12)
				.shadow(
					color: .black.opacity(0.7),
					radius: 10,
					x: 0,
					y: 0
				)
		}
    }
}

#Preview {
    //VINSearchView()
	SearchView()
}
