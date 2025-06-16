//
//  TitleScreen.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//


//
//  TitleScreen.swift
//  HybridApp
//
//  Created by Tyler Allen on 6/11/25.
//


import SwiftUI

struct TitleScreen: View {
	var body: some View {
		ZStack {
			TitleBackground()
			VStack(spacing: 20) {
				Text("Native App")
					.font(.largeTitle)
					.foregroundColor(.white)
					.bold()
				VStack(spacing: 10) {
					TitleButton(title: "New Game", action: {})
					TitleButton(title: "Load Game", action: {})
					TitleButton(title: "Options", action: {})
					TitleButton(title: "Credits", action: {})
				}
			}
		}
	}
}

#Preview {
	TitleScreen()
}
