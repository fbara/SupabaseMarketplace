//
//  User.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 1/27/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let createdAt: Date
    var profileImageUrl: String? = nil
    var totalSales: Double
    var itemsSold: Int
    var itemsPurchased: Int
    
    // Code the incoming data from the backend and map them into the User struct
    private enum CodingKeys: String, CodingKey {
        case id, email, username, createdAt = "created_at", profileImageUrl = "profile_image_url", totalSales = "total_sales", itemsSold = "items_sold_count", itemsPurchased = "items_purchased_count"
    }
}

// Mock for User
extension User {
    static var mock = User(id: UUID().uuidString, email: "test@gmail.com", username: "test_user", createdAt: Date(), profileImageUrl: "https://picsum.photos/200/200", totalSales: 0, itemsSold: 0, itemsPurchased: 0)
}
