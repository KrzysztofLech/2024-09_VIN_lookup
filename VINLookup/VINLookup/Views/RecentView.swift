//  RecentView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct RecentView: View {

	@Binding var vinNumbers: [String]
	let onSelectAction: (String) -> Void

    var body: some View {
		if vinNumbers.isEmpty {
			Text(AppString.noDataText)
				.foregroundStyle(Color.theme2)
		} else {
			List(vinNumbers, id: \.self) { number in
				Text(number)
					.foregroundStyle(Color.theme2)
					.onTapGesture {
						onSelectAction(number)
					}
			}
		}
    }
}

#Preview {
	RecentView(vinNumbers: Binding.constant([])) { _ in}
}

#Preview {
	RecentView(vinNumbers: Binding.constant(["JH4KA7561PC008269", "AB4KA7561PC008123"])) { _ in}
}
