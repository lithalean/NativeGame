//
//  MenuButton.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - WWDC25 Menu Button Component
struct MenuButton: View {
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            // WWDC25 haptic feedback
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
            action()
        }) {
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Menu")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                // WWDC25 glassmorphism effect
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 4)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity
        ) { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        } perform: {
            // Empty perform block
        }
    }
}

#Preview("WWDC25 Menu Button") {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 20) {
            Text("WWDC25 Menu Button")
                .foregroundColor(.white)
                .font(.title)
            
            MenuButton {
                print("Menu tapped")
            }
        }
    }
}
