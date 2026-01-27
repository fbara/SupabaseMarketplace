//
//  ContentView.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                Text("Main interface...")
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task { await authManager.refreshUser() }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}

