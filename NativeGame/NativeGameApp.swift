//
//  NativeGameApp.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI
import SwiftData

@main
struct NativeGameApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainGameView()
                .preferredColorScheme(.dark) // Gaming apps typically use dark mode
                .statusBarHidden() // Hide status bar for immersive gaming
        }
        .modelContainer(sharedModelContainer)
    }
}
