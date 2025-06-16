//
//  SplashScreen.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var showSplash: Bool
    var onComplete: (() -> Void)? = nil
    
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var showingTitle: Bool = false
    @State private var showingSubtitle: Bool = false
    
    var body: some View {
        ZStack {
            // Use your SplashBackground from Styles/
            SplashBackground()
            
            VStack(spacing: 20) {
                Spacer()
                
                // Game logo/icon
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 80, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .blue.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .shadow(color: .blue.opacity(0.5), radius: 20)
                
                // Game title
                if showingTitle {
                    VStack(spacing: 8) {
                        Text("NativeGame")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, .blue.opacity(0.9)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        if showingSubtitle {
                            Text("Ultimate Darwin ARM64 Gaming")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                
                Spacer()
                
                // Loading indicator
                if showingSubtitle {
                    HStack(spacing: 12) {
                        ProgressView()
                            .scaleEffect(0.8)
                            .tint(.white.opacity(0.7))
                        
                        Text("Loading Gaming Engine...")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .transition(.opacity)
                    .padding(.bottom, 40)
                }
            }
            .padding()
        }
        .onAppear {
            startAnimationSequence()
        }
    }
    
    // MARK: - Animation Sequence
    private func startAnimationSequence() {
        // Logo animation
        withAnimation(.easeOut(duration: 1.0)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        
        // Title animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.8)) {
                showingTitle = true
            }
        }
        
        // Subtitle and loading animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation(.easeInOut(duration: 0.6)) {
                showingSubtitle = true
            }
        }
        
        // Auto-complete after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completeSplash()
        }
    }
    
    private func completeSplash() {
        withAnimation(.easeInOut(duration: 0.5)) {
            showSplash = false
        }
        onComplete?()
    }
}

// MARK: - Convenience Initializers
extension SplashScreen {
    // Simple version with just binding
    init(showSplash: Binding<Bool>) {
        self._showSplash = showSplash
        self.onComplete = nil
    }
    
    // Version with completion callback
    init(showSplash: Binding<Bool>, onComplete: @escaping () -> Void) {
        self._showSplash = showSplash
        self.onComplete = onComplete
    }
}

#Preview("Splash Screen") {
    SplashScreen(showSplash: .constant(true))
}
