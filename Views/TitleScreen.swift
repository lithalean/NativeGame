//
//  TitleScreen.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

struct TitleScreen: View {
    // Navigation actions
    var onNewGame: (() -> Void)
    var onContinue: (() -> Void)
    var onSettings: (() -> Void)
    var onCredits: (() -> Void)
    
    @State private var titleOpacity: Double = 0.0
    @State private var showingButtons: Bool = false
    @State private var buttonsOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Use your TitleBackground from Styles/
            TitleBackground()
            
            VStack(spacing: 0) {
                // Centered game title section
                VStack(spacing: 12) {
                    Text("NativeGame")
                        .font(.system(size: 64, weight: .bold, design: .rounded)) // Bigger title
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .blue.opacity(0.8)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .blue.opacity(0.5), radius: 15)
                        .opacity(titleOpacity)
                    
                    Text("Ultimate Darwin ARM64 Gaming")
                        .font(.system(size: 20, weight: .medium)) // Slightly bigger subtitle
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(titleOpacity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center in viewport
                .onAppear {
                    // Title fade in
                    withAnimation(.easeIn(duration: 1.0)) {
                        titleOpacity = 1.0
                    }
                    
                    // Title fade out and buttons slide in from right
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.8)) {
                            titleOpacity = 0.0
                        }
                        
                        // Start button slide-in after title starts fading
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                showingButtons = true
                                buttonsOpacity = 1.0
                            }
                        }
                    }
                }
                
                // Centered menu buttons
                if showingButtons {
                    VStack(spacing: 20) {
                        // Primary action - New Game
                        TitleButton.primary(
                            title: "New Game",
                            icon: "play.circle.fill",
                            action: onNewGame
                        )
                        
                        // Secondary actions
                        TitleButton.secondary(
                            title: "Continue",
                            icon: "arrow.clockwise.circle.fill",
                            action: onContinue
                        )
                        
                        TitleButton.secondary(
                            title: "Settings",
                            icon: "gearshape.circle.fill",
                            action: onSettings
                        )
                        
                        TitleButton.standard(
                            title: "Credits",
                            icon: "info.circle.fill",
                            action: onCredits
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Center in viewport
                    .opacity(buttonsOpacity)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .padding(.horizontal, 40)
                }
                
                // Version and build info (always at bottom)
                VStack(spacing: 4) {
                    Text("Phase 2 - Enhancement Build")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text("Darwin ARM64 Optimized")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.white.opacity(0.4))
                }
                .opacity(buttonsOpacity)
                .padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Convenience Initializers
extension TitleScreen {
    // Version for previews with empty actions
    static var preview: TitleScreen {
        TitleScreen(
            onNewGame: { print("New Game") },
            onContinue: { print("Continue") },
            onSettings: { print("Settings") },
            onCredits: { print("Credits") }
        )
    }
}

#Preview("Title Screen") {
    TitleScreen.preview
}
