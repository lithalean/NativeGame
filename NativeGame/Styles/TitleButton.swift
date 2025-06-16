//
//  TitleButton.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//


import SwiftUI

struct TitleButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 100, height: 25)
                .padding()
                .background(Color(red: 0.761, green: 0.761, blue: 0.761))
                .foregroundColor(Color(red: 0.133, green: 0.133, blue: 0.133))
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(red: 0.133, green: 0.133, blue: 0.133), lineWidth: 2)
                )
        }
        // Remove .frame(minHeight: 200) here
    }
}

