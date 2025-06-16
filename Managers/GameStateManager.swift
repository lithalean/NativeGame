//
//  GameStateManager.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

// MARK: - Game State Manager with NavigationStack
@Observable
class GameStateManager {
    var navigationPath = NavigationPath()
    
    // MARK: - Navigation Methods
    func navigateToGame() {
        navigationPath.append(GameDestination.game)
    }
    
    func navigateToLoadGame() {
        navigationPath.append(GameDestination.loadGame)
    }
    
    func navigateToSettings() {
        navigationPath.append(GameDestination.settings)
    }
    
    func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navigationPath = NavigationPath()
    }
    
    // MARK: - Helper Properties
    var isInGame: Bool {
        navigationPath.count > 0
    }
}
