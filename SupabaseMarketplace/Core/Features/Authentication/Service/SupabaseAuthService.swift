//
//  SupabaseAuthService.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/19/26.
//

import Foundation
import Supabase

struct SupabaseAuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    // Sign user in
    func signIn(email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    // Sign out the user
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    // Get user session to see current user logged in
    func getCurrentUserSession() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
    
    // Sign up new user
    func signUp(email: String, password: String, username: String) async throws -> String {
        let response = try await client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        // upload user data to supabase here
        try await uploadUserData(with: userId, email: email, username: username)
        return userId
    }
    
    // Upload the user data to Supabase one time for a brand new user
    private func uploadUserData(with uid: String, email: String, username: String) async throws {
        let user = User(
            id: uid,
            email: email,
            username: username,
            createdAt: Date(),
            totalSales: 0,
            itemsSold: 0,
            itemsPurchased: 0
        )
        
        try await client.from("users").insert(user).execute()
    }
}
