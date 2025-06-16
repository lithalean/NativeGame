//
//  DynamicTitleBar.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - Title Configuration
struct TitleConfiguration {
    let title: String
    let subtitle: String
    let animationType: TitleAnimationType
    
    // Predefined configurations for different panels
    static let main = TitleConfiguration(
        title: "NativeGame",
        subtitle: "Ultimate Darwin ARM64 Gaming",
        animationType: .fadeScale
    )
    
    static let loadGame = TitleConfiguration(
        title: "Load Game",
        subtitle: "Select Your Save File",
        animationType: .slideFromRight
    )
    
    static let settings = TitleConfiguration(
        title: "Settings",
        subtitle: "Configure Your Experience",
        animationType: .slideFromRight
    )
    
    static let newGame = TitleConfiguration(
        title: "New Game",
        subtitle: "Begin Your Adventure",
        animationType: .slideFromRight
    )
}

// MARK: - Title Animation Types
enum TitleAnimationType {
    case fadeScale      // For initial load (main screen)
    case slideFromRight // For panel transitions
    case slideFromLeft  // For back transitions
    case instant        // For immediate changes
}

// MARK: - Dynamic Title Bar Component
struct DynamicTitleBar: View {
    let configuration: TitleConfiguration
    @State private var titleOpacity: Double = 0.0
    @State private var titleScale: CGFloat = 0.8
    @State private var titleOffset: CGFloat = 0.0
    @State private var isVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            // Main Title
            Text(configuration.title)
                .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                .foregroundStyle(titleGradient)
                .shadow(color: .blue.opacity(0.5), radius: 15)
                .opacity(titleOpacity)
                .scaleEffect(titleScale)
                .offset(x: titleOffset)
            
            // Subtitle
            Text(configuration.subtitle)
                .font(.system(size: subtitleFontSize, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .opacity(titleOpacity)
                .offset(x: titleOffset)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
        .onAppear {
            performInitialAnimation()
        }
        .onChange(of: configuration.title) { _, _ in
            performTransitionAnimation()
        }
    }
    
    // MARK: - Dynamic Properties
    private var titleFontSize: CGFloat {
        switch configuration.title {
        case "NativeGame": return 64  // Main title bigger
        default: return 56            // Panel titles slightly smaller
        }
    }
    
    private var subtitleFontSize: CGFloat {
        switch configuration.title {
        case "NativeGame": return 20  // Main subtitle bigger
        default: return 18            // Panel subtitles slightly smaller
        }
    }
    
    private var titleGradient: some ShapeStyle {
        LinearGradient(
            colors: [.white, .blue.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Animation Methods
    private func performInitialAnimation() {
        guard !isVisible else { return }
        isVisible = true
        
        switch configuration.animationType {
        case .fadeScale:
            // Initial load animation (main screen)
            withAnimation(.easeOut(duration: 1.2)) {
                titleOpacity = 1.0
                titleScale = 1.0
            }
            
        case .slideFromRight:
            // Start from right side
            titleOffset = 300
            withAnimation(.easeOut(duration: 0.8)) {
                titleOpacity = 1.0
                titleOffset = 0
                titleScale = 1.0
            }
            
        case .slideFromLeft:
            // Start from left side
            titleOffset = -300
            withAnimation(.easeOut(duration: 0.8)) {
                titleOpacity = 1.0
                titleOffset = 0
                titleScale = 1.0
            }
            
        case .instant:
            titleOpacity = 1.0
            titleScale = 1.0
            titleOffset = 0
        }
    }
    
    private func performTransitionAnimation() {
        switch configuration.animationType {
        case .slideFromRight:
            // Slide out left, slide in right
            withAnimation(.easeIn(duration: 0.4)) {
                titleOpacity = 0.0
                titleOffset = -300
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                titleOffset = 300
                withAnimation(.easeOut(duration: 0.6)) {
                    titleOpacity = 1.0
                    titleOffset = 0
                }
            }
            
        case .slideFromLeft:
            // Slide out right, slide in left
            withAnimation(.easeIn(duration: 0.4)) {
                titleOpacity = 0.0
                titleOffset = 300
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                titleOffset = -300
                withAnimation(.easeOut(duration: 0.6)) {
                    titleOpacity = 1.0
                    titleOffset = 0
                }
            }
            
        case .fadeScale:
            // Simple fade transition
            withAnimation(.easeInOut(duration: 0.6)) {
                titleOpacity = 0.3
                titleScale = 0.95
            }
            
            withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
                titleOpacity = 1.0
                titleScale = 1.0
            }
            
        case .instant:
            // No animation
            break
        }
    }
}

// MARK: - Title Bar Manager for Panel System
@Observable
class TitleBarManager {
    var currentConfiguration: TitleConfiguration = .main
    
    func updateTitle(for panelDestination: TitlePanelDestination) {
        let newConfig = configuration(for: panelDestination)
        
        // Only update if different to trigger animation
        if currentConfiguration.title != newConfig.title {
            currentConfiguration = newConfig
        }
    }
    
    private func configuration(for destination: TitlePanelDestination) -> TitleConfiguration {
        switch destination {
        case .main: return .main
        case .loadGame: return .loadGame
        case .settings: return .settings
        }
    }
}

// MARK: - Enhanced Title Bar with Panel Integration
struct EnhancedDynamicTitleBar: View {
    @Bindable var titleBarManager: TitleBarManager
    let panelDestination: TitlePanelDestination
    
    var body: some View {
        DynamicTitleBar(configuration: titleBarManager.currentConfiguration)
            .onAppear {
                titleBarManager.updateTitle(for: panelDestination)
            }
            .onChange(of: panelDestination) { _, newDestination in
                titleBarManager.updateTitle(for: newDestination)
            }
    }
}

#Preview("Dynamic Title Transitions") {
    struct PreviewWrapper: View {
        @State private var currentPanel: TitlePanelDestination = .main
        @State private var titleBarManager = TitleBarManager()
        
        var body: some View {
            ZStack {
                // Use your TitleBackground from Styles/
                Color.black.ignoresSafeArea()
                
                VStack {
                    EnhancedDynamicTitleBar(
                        titleBarManager: titleBarManager,
                        panelDestination: currentPanel
                    )
                    
                    Spacer()
                    
                    // Test buttons to see transitions
                    VStack(spacing: 16) {
                        Button("Main Panel") {
                            currentPanel = .main
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue.opacity(0.3))
                        .cornerRadius(8)
                        
                        Button("Load Game Panel") {
                            currentPanel = .loadGame
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue.opacity(0.3))
                        .cornerRadius(8)
                        
                        Button("Settings Panel") {
                            currentPanel = .settings
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue.opacity(0.3))
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    return PreviewWrapper()
}
