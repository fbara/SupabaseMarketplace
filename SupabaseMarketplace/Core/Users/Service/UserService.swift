//
//  UserService.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/27/26.
//

import Foundation
import Supabase

// Fetch user data and update the data to Supabase tables
struct UserService {
    
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func fetchCurrentUser() async throws -> User {
        // get Supabase User from Auth session
        let supabaseUser = try await client.auth.session.user
        
        // run a select statement on 'users' table to fetch rows
        // where 'id' matches the current user, return value
        return try await client.from("users")
            .select()
            .eq("id", value: supabaseUser.id.uuidString)
            .single()
            .execute()
            .value
    }
}
