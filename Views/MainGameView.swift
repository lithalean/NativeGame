//
//  MainGameView.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - Game Navigation Destinations
enum GameDestination: Hashable {
    case title
    case game
    case settings
    case loadGame
}

// MARK: - Main Game Navigation Stack
struct MainGameView: View {
    @State private var gameState = GameStateManager()
    @State private var showSplash = true
    
    var body: some View {
        NavigationStack(path: $gameState.navigationPath) {
            ZStack {
                // Premium gaming background
                LinearGradient(
                    colors: [.black, .blue.opacity(0.3), .purple.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if showSplash {
                    // Use your modular SplashScreen component
                    SplashScreen(showSplash: $showSplash)
                } else {
                    // Use your modular TitleScreen component with navigation
                    TitleScreen(
                        onNewGame: { gameState.navigateToGame() },
                        onContinue: { gameState.navigateToLoadGame() },
                        onSettings: { gameState.navigateToSettings() },
                        onCredits: { print("Credits - Coming Soon") }
                    )
                }
            }
            .navigationDestination(for: GameDestination.self) { destination in
                switch destination {
                case .title:
                    TitleScreen(
                        onNewGame: { gameState.navigateToGame() },
                        onContinue: { gameState.navigateToLoadGame() },
                        onSettings: { gameState.navigateToSettings() },
                        onCredits: { print("Credits - Coming Soon") }
                    )
                    
                case .game:
                    // Use your actual ContentView component
                    NavigatingContentView(gameState: gameState)
                    
                case .settings:
                    GameSettingsView(gameState: gameState)
                    
                case .loadGame:
                    GameLoadView(gameState: gameState)
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
}

// MARK: - Navigation-Enabled Content View (wraps your existing ContentView)
struct NavigatingContentView: View {
    let gameState: GameStateManager
    
    var body: some View {
        ZStack {
            // Gaming background
            Color.black.ignoresSafeArea()
            
            VStack {
                // Game header with back navigation
                HStack {
                    Button(action: { gameState.navigateBack() }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("Menu")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                    }
                    
                    Spacer()
                    
                    // Performance indicator
                    HStack(spacing: 4) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        Text("120 FPS")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding()
                
                Spacer()
                
                // Main game content area - Integration point for your actual ContentView
                VStack(spacing: 20) {
                    
                    // Placeholder for your actual ContentView or GameEngine view
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue.opacity(0.2))
                        .stroke(.blue.opacity(0.5), lineWidth: 2)
                        .frame(height: 300)
                        .overlay(
                            VStack {
                                Image(systemName: "gamecontroller.fill")
                                    .font(.system(size: 48))
                                    .foregroundColor(.blue.opacity(0.7))
                                Text("Your actual ContentView goes here")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.blue.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Settings and Load Game Views
struct GameSettingsView: View {
    let gameState: GameStateManager
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                VStack(spacing: 16) {
                    TitleButton.secondary(
                        title: "Audio Settings",
                        icon: "speaker.wave.2.fill",
                        action: { print("Audio Settings") }
                    )
                    
                    TitleButton.secondary(
                        title: "Graphics Settings",
                        icon: "display",
                        action: { print("Graphics Settings") }
                    )
                    
                    TitleButton.secondary(
                        title: "Controls",
                        icon: "gamecontroller.fill",
                        action: { print("Controls") }
                    )
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                TitleButton.standard(
                    title: "Back to Menu",
                    icon: "chevron.left",
                    action: { gameState.navigateBack() }
                )
                .padding(.horizontal, 40)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct GameLoadView: View {
    let gameState: GameStateManager
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Load Game")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Save files will appear here")
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                TitleButton.standard(
                    title: "Back to Menu",
                    icon: "chevron.left",
                    action: { gameState.navigateBack() }
                )
                .padding(.horizontal, 40)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MainGameView()
}
