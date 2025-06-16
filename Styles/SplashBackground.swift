//
//  SplashBackground.swift
//  NativeGame
//
//  Created by Tyler Allen on 6/16/25.
//

import SwiftUI

struct SplashBackground: View {
    var body: some View {
        // Premium gaming background
        LinearGradient(
            colors: [.black, .blue.opacity(0.3), .purple.opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    TitleBackground()
}
