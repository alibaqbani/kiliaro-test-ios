//
//  NetworkError.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

enum NetworkError {
    case invalidURL
    case requestFailed
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please check and try again."
        case .requestFailed:
            return "Request failed. Please check your internet connection and try again."
        }
    }
}
