//
//  SupabaseMarketplaceApp.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import SwiftUI

@main
struct SupabaseMarketplaceApp: App {
    @State private var authManager = AuthManager()
    @State private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
                .environment(userManager)
        }
    }
}
