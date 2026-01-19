//
//  AuthManager.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/19/26.
//

import Foundation

@Observable
final class AutAuthManager {
    var authState: AuthState = .unknown
    var currentUserID: String?
    
    private let authService: SupabaseAuthService
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
    
    // Sign up the user
    func signUp(email: String, password: String, username: String) async {
        do {
            currentUserID = try await authService.signUp(email: email, password: password, username: username)
            authState = .authenticated
        } catch {
            print("Sign-up error: \(error)")

        }
    }
    
    // Sign in the user
    func signIn(email: String, password: String) async {
        do {
            currentUserID = try await authService.signIn(email: email, password: password)
            authState = .authenticated
            print("DEBUG: Auth state \(authState)")
        } catch {
            print("Sign-in error: \(error)")
        }
    }
    
    // Sign out the user
    func signOut() async {
        do {
            try await authService.signOut()
            currentUserID = nil
            authState = .unauthorized
        } catch {
            print("Sign-out error: \(error)")
        }
    }
    
    // Refresh the user state
    func refreshUser() async {
        do {
            let userSessionID = try await authService.getCurrentUserSession()
            
            if let userSessionID {
                self.authState = .authenticated
                self.currentUserID = userSessionID
            }
        } catch {
            print("Refresh user error: \(error)")
            currentUserID = nil
            authState = .unauthorized
        }
    }
}
