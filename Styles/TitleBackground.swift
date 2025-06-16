//
//  TitleBackground.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//


import SwiftUI

struct TitleBackground: View {
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				Rectangle()
					.fill(Color(red: 0.322, green: 0.651, blue: 0.906)) // #52a6e7
					.frame(height: geometry.size.height / 1.9)
				Rectangle()
					.fill(Color(red: 0.486, green: 0.780, blue: 0.251)) // #7cc740
					.frame(height: geometry.size.height / 1.9)
			}
			.ignoresSafeArea()
		}
	}
}

