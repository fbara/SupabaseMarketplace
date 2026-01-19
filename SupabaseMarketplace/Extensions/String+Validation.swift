//
//  String+Validation.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self)
    }
}
