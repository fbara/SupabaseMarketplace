//
//  ContentView.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                UserProfileView()
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task { await authManager.refreshUser() }
        // once we know we have a logged-in user, fetch the info from Supabase
        .task(id: authManager.authState) {
            // runs every time the authState changes
            guard authManager.authState == .authenticated else { return }
            // fetch the user's data
            await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
        .environment(UserManager())
}

