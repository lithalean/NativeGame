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
    @State private var buttonsOpacity: Double = 0.0
    @State private var showingButtons: Bool = false
    
    var body: some View {
        ZStack {
            // Use your TitleBackground from Styles/
            TitleBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Game title section
                VStack(spacing: 12) {
                    Text("NativeGame")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
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
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(titleOpacity)
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 1.0)) {
                        titleOpacity = 1.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            showingButtons = true
                            buttonsOpacity = 1.0
                        }
                    }
                }
                
                Spacer()
                
                // Menu buttons using your TitleButton from Styles/
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
                    .opacity(buttonsOpacity)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Version and build info
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
