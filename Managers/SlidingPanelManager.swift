//
//  SlidingPanelManager.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - Panel Destinations
enum TitlePanelDestination: CaseIterable {
    case main
    case loadGame  // Changed from 'continue' to avoid keyword conflict
    case settings
    
    var title: String {
        switch self {
        case .main: return "NativeGame"
        case .loadGame: return "Load Game"
        case .settings: return "Settings"
        }
    }
}

// MARK: - Sliding Panel State Manager
@Observable
class SlidingPanelManager {
    var currentPanel: TitlePanelDestination = .main
    var isTransitioning: Bool = false
    
    // MARK: - Panel Navigation
    func navigateToPanel(_ destination: TitlePanelDestination) {
        guard !isTransitioning && currentPanel != destination else { return }
        
        withAnimation(.easeInOut(duration: 0.8)) {
            isTransitioning = true
            currentPanel = destination
        }
        
        // Reset transition state after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.isTransitioning = false
        }
    }
    
    func navigateToMain() {
        navigateToPanel(.main)
    }
    
    func navigateToLoadGame() {
        navigateToPanel(.loadGame)
    }
    
    func navigateToSettings() {
        navigateToPanel(.settings)
    }
    
    // MARK: - Panel State Helpers
    var isMainPanel: Bool { currentPanel == .main }
    var isLoadGamePanel: Bool { currentPanel == .loadGame }
    var isSettingsPanel: Bool { currentPanel == .settings }
}

// MARK: - Modern Sliding Title Screen
struct ModernSlidingTitleScreen: View {
    @State private var panelManager = SlidingPanelManager()
    @State private var titleBarManager = TitleBarManager()
    @State private var showingContent: Bool = false
    
    // Navigation actions
    var onNewGame: (() -> Void)  // This will navigate to actual game
    var onCredits: (() -> Void)
    
    var body: some View {
        ZStack {
            // Use your TitleBackground from Styles/
            TitleBackground()
            
            VStack(spacing: 0) {
                // Dynamic Title Bar using your Styles/DynamicTitleBar component
                EnhancedDynamicTitleBar(
                    titleBarManager: titleBarManager,
                    panelDestination: panelManager.currentPanel
                )
                
                Spacer()
                
                // Sliding Panel Content Area
                ZStack {
                    // Main Panel (Title Screen)
                    if panelManager.isMainPanel {
                        MainPanelView(
                            onNewGame: onNewGame,
                            onContinue: { panelManager.navigateToLoadGame() },
                            onSettings: { panelManager.navigateToSettings() }
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    }
                    
                    // Load Game Panel
                    if panelManager.isLoadGamePanel {
                        ContinuePanelView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }
                    
                    // Settings Panel
                    if panelManager.isSettingsPanel {
                        SettingsPanelView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(showingContent ? 1.0 : 0.0)
                
                Spacer()
                
                // Bottom Button (Stationary - Credits or Back to Menu)
                VStack {
                    if panelManager.isMainPanel {
                        TitleButton.standard(
                            title: "Credits",
                            icon: "info.circle.fill",
                            action: onCredits
                        )
                    } else {
                        TitleButton.standard(
                            title: "Back to Menu",
                            icon: "chevron.left",
                            action: { panelManager.navigateToMain() }
                        )
                    }
                }
                .opacity(showingContent ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.6), value: panelManager.currentPanel)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            startInitialAnimation()
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Initial Animation
    private func startInitialAnimation() {
        // Content fade in after brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeOut(duration: 0.8)) {
                showingContent = true
            }
        }
    }
}

// MARK: - Main Panel (Title Screen Buttons)
struct MainPanelView: View {
    let onNewGame: () -> Void
    let onContinue: () -> Void
    let onSettings: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            TitleButton.primary(
                title: "New Game",
                icon: "play.circle.fill",
                action: onNewGame
            )
            
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
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Continue Panel (Load Game Buttons)
struct ContinuePanelView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Glass effect buttons for save slots (placeholder for now)
            ForEach(1...3, id: \.self) { slot in
                Button(action: {
                    print("Load Save Slot \(slot)")
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "doc.fill")
                            .font(.system(size: 20, weight: .semibold))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Save Slot \(slot)")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Level 15 • 4 hours played")
                                .font(.system(size: 14, weight: .medium))
                                .opacity(0.7)
                        }
                        
                        Spacer()
                        
                        Text("06/16")
                            .font(.system(size: 12, weight: .medium))
                            .opacity(0.6)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .frame(minWidth: 200, maxWidth: 280, minHeight: 56)
                    .background(
                        // Glass effect placeholder - will enhance later
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                            .opacity(0.8)
                    )
                }
            }
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Settings Panel
struct SettingsPanelView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Glass effect buttons for settings (placeholder for now)
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
    }
}

#Preview {
    ModernSlidingTitleScreen(
        onNewGame: { print("New Game") },
        onCredits: { print("Credits") }
    )
}
