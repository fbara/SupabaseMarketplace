//
//  String+Validation.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import Foundation

//extension String {
//    func isValidEmail() -> Bool {
//        let regex = #"^[A—Z0—9a—z•_%+—]+@[A-Za—z0-9.—]+\•[A-Za-z]{2,}$"#
//        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self)
//    }
//}

extension String {
    func isValidEmail() -> Bool {
        // This is a basic regex for demonstration purposes
        let emailRegEx = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
}
