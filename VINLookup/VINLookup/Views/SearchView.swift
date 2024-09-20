//  SearchView.swift
//  Created by Krzysztof Lech on 19/09/2024.

import SwiftUI

struct SearchView: View {
    var body: some View {
		ScrollView {
			VINSearchView()
				.padding(.top, 100)
				.padding(.horizontal, 32)
		}
		.scrollDisabled(true)
    }
}

#Preview {
    SearchView()
}
