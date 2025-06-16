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
    var icon: String? = nil
    var isSecondary: Bool = false
    var isPrimary: Bool = false
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Optional icon support
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            .foregroundColor(buttonTextColor)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(minWidth: 200, maxWidth: 280, minHeight: 56) // Apple-recommended menu button dimensions
            .background(buttonBackground)
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
    
    // MARK: - Simplified Design Properties
    
    private var buttonTextColor: Color {
        if isPrimary {
            return .black
        } else {
            return .white.opacity(0.9)
        }
    }
    
    @ViewBuilder
    private var buttonBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(backgroundFill)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(strokeColor, lineWidth: strokeWidth)
            )
    }
    
    private var backgroundFill: Color {
        if isPrimary {
            return .white
        } else if isSecondary {
            return .white.opacity(0.15)
        } else {
            return .white.opacity(0.2)
        }
    }
    
    private var strokeColor: Color {
        if isPrimary {
            return .clear
        } else {
            return .white.opacity(0.3)
        }
    }
    
    private var strokeWidth: CGFloat {
        isPrimary ? 0 : 1
    }
}

// MARK: - Button Variants (Convenience Initializers)

extension TitleButton {
    // Primary action button (most important action)
    static func primary(title: String, icon: String? = nil, action: @escaping () -> Void) -> TitleButton {
        TitleButton(title: title, action: action, icon: icon, isPrimary: true)
    }
    
    // Secondary action button (less important actions)
    static func secondary(title: String, icon: String? = nil, action: @escaping () -> Void) -> TitleButton {
        TitleButton(title: title, action: action, icon: icon, isSecondary: true)
    }
    
    // Standard button (default styling)
    static func standard(title: String, icon: String? = nil, action: @escaping () -> Void) -> TitleButton {
        TitleButton(title: title, action: action, icon: icon)
    }
}

#Preview("Button Variants") {
    ZStack {
        // Gaming background for preview
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 20) {
            Text("Gaming Buttons")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            
            VStack(spacing: 16) {
                // Primary button (main action)
                TitleButton.primary(
                    title: "New Game",
                    icon: "play.circle.fill",
                    action: { print("New Game") }
                )
                
                // Secondary buttons
                TitleButton.secondary(
                    title: "Continue",
                    icon: "arrow.clockwise.circle.fill",
                    action: { print("Continue") }
                )
                
                // Standard button
                TitleButton.standard(
                    title: "Settings",
                    action: { print("Settings") }
                )
            }
            .padding(.horizontal, 40)
        }
    }
}
