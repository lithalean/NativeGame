//
//  SplashScreen.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//


import SwiftUI

// Add this to your Views folder
struct SplashScreen: View {
    @State private var isAnimating = false
    @State private var titleOpacity: Double = 0.0
    @State private var backgroundOpacity: Double = 0.0
    @Binding var showSplash: Bool
    
    let splashDuration: Double = 2.5
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
            
            // Animated particles
            ForEach(0..<15, id: \.self) { index in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: CGFloat.random(in: 2...6))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .opacity(isAnimating ? 0.6 : 0.0)
                    .scaleEffect(isAnimating ? 1.2 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 2...4))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...1)),
                        value: isAnimating
                    )
            }
            
            // Main content centered
            VStack {
                Spacer()
                
                // App name/title - centered on screen
                Text("Godot")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .opacity(titleOpacity)
                    .overlay(
                        // Lighthouse light effect
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.6),
                                        Color.clear,
                                        Color.white.opacity(0.6)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 300, height: 100)
                            .blur(radius: 20)
                            .opacity(isAnimating ? 0.8 : 0.0)
                            .animation(
                                Animation.easeInOut(duration: 2.0)
                                    .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                            .mask(
                                Text("Godot")
                                    .font(.system(size: 64, weight: .bold, design: .rounded))
                            )
                    )
                
                Spacer()
            }
            
            // Loading dots - positioned at bottom with Mac dock padding
            VStack {
                Spacer()
                HStack(spacing: 12) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 10, height: 10)
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .opacity(isAnimating ? 1.0 : 0.5)
                            .animation(
                                Animation.easeInOut(duration: 0.8)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                }
                .opacity(titleOpacity)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            startSplashAnimation()
        }
    }
    
    func startSplashAnimation() {
        // Background fade in
        withAnimation(.easeIn(duration: 0.4)) {
            backgroundOpacity = 1.0
        }
        
        // Title fade in
        withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
            titleOpacity = 1.0
        }
        
        // Start particle animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = true
        }
        
        // Hide splash screen after duration
        DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {
            withAnimation(.easeOut(duration: 0.5)) {
                showSplash = false
            }
        }
    }
}

// Preview
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(showSplash: .constant(true))
    }
}
