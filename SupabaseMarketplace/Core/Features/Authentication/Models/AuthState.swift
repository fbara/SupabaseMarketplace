//
//  AuthState.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/19/26.
//

import Foundation

// Authenticated state starts as 'unknown' until we know if the user authenticated or not
enum AuthState {
    case authenticated
    case unauthenticated
    case unknown
}
