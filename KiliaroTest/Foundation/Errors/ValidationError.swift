//
//  ValidationError.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/27/23.
//

import Foundation

enum ValidationError {
    case invalidSharedKey
}

extension ValidationError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidSharedKey:
            return "Invalid or expired shared key."
        }
    }
}
