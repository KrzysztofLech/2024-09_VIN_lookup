//  VINDataView.swift
//  Created by Krzysztof Lech on 23/09/2024.

import SwiftUI

struct VINDataView: View {
	let data: VINData

	private let cornerRadius: CGFloat = 8
	private let borderWidth: CGFloat = 4
	private let mainColor = VINColor.theme1
	private let textColor = VINColor.theme2
	private let backgroundColor = VINColor.light

    var body: some View {
		VStack(alignment: .center, spacing: 0) {
			Text(data.vin)
				.font(.system(size: 18, weight: .light))
				.foregroundStyle(backgroundColor)
				.padding(8)
				.frame(maxWidth: .infinity)
				.background {
					UnevenRoundedRectangle(
						topLeadingRadius: cornerRadius,
						topTrailingRadius: cornerRadius
					)
					.foregroundColor(mainColor)
				}

			ScrollView {
				VStack(alignment: .leading, spacing: 8) {
					dataTextView(title: "Country:", text: data.country)
					dataTextView(title: "Manufacturer:", text: data.manufacturer)
					dataTextView(title: "Model:", text: data.model)
					dataTextView(title: "Class:", text: data.class)
					dataTextView(title: "Region:", text: data.region)
					dataTextView(title: "WMI:", text: data.wmi)
					dataTextView(title: "VDS:", text: data.vds)
					dataTextView(title: "VIS:", text: data.vis)
					dataTextView(title: "Year:", text: data.yearString)
				}
				.padding(16)
			}
		}

		.background {
			RoundedRectangle(cornerRadius: cornerRadius)
				.foregroundStyle(backgroundColor)
				.shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
		}

		.overlay {
			RoundedRectangle(cornerRadius: cornerRadius)
				.strokeBorder(mainColor, lineWidth: borderWidth)
		}
    }

	private func dataTextView(title: String, text: String) -> some View {
		HStack(alignment: .firstTextBaseline, spacing: 16) {
			Text(title)
				.font(.system(size: 12, weight: .semibold))
				.frame(width: 90, alignment: .leading)

			if text.hasPrefix(VINString.Data.premiumDataPrefix) {
				Text(VINString.Data.premiumTitle)
					.padding(4)
					.font(.system(size: 8, weight: .semibold))
					.background{
						RoundedRectangle(cornerRadius: 4)
							.foregroundColor(VINColor.theme3)
					}
					.padding(.vertical, 3)
			} else {
				Text(text)
					.font(.system(size: 18, weight: .regular))
			}

			Spacer(minLength: 0)
		}
		.foregroundColor(textColor)
	}
}

struct VINDataView_Previews: PreviewProvider {
	static var previews: some View {
		VINDataView(data: VINData.exampleVIN)
			.previewLayout(.sizeThatFits)
			.padding(32)
	}
}
