//
//  EnhancedGameView.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//


//
//  EnhancedGameView.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - Enhanced Game View with WWDC25 Menu Button
struct EnhancedGameView: View {
    let onBackToMenu: () -> Void
    
    var body: some View {
        ZStack {
            // Gaming background
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Game header with WWDC25 menu button from Styles/
                HStack {
                    MenuButton(action: onBackToMenu)
                    
                    Spacer()
                    
                    // Performance indicator with WWDC25 styling
                    HStack(spacing: 6) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        
                        Text("120 FPS")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .overlay(
                                Capsule()
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Main game content area - full screen with slight border
                RoundedRectangle(cornerRadius: 16)
                    .fill(.blue.opacity(0.2))
                    .stroke(.blue.opacity(0.5), lineWidth: 2)
                    .overlay(
                        VStack(spacing: 16) {
                            Image(systemName: "gamecontroller.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.blue.opacity(0.7))
                            
                            Text("GameEngine View")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.blue.opacity(0.8))
                            
                            Text("Your ContentView.swift or\nGodotView integration here")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.blue.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                    )
                    .padding(12) // Slight border around the edges
                
                Spacer(minLength: 0)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview("Enhanced Game View") {
    EnhancedGameView(
        onBackToMenu: { print("Back to Menu") }
    )
}