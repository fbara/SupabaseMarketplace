//
//  UserManager.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/27/26.
//

import Foundation

@Observable
final class UserManager {
    var currentUser: User?
    var isLoading = false
    
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
    }
    
    // fetch the current user
    func fetchCurrentUser() async {
        isLoading = true
        
        // when function completes, defer to isLoading to be false
        defer { isLoading = false }
        do {
            self.currentUser = try await service.fetchCurrentUser()
            print("DEBUG: Current user \(currentUser)")
        } catch {
            print("DEBUG: Failed to fetch current user: \(error)")
        }
    }
}
