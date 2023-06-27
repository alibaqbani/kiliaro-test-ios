//
//  ViewPhases.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/25/23.
//

import Foundation

public enum LoadingPhase{
    case inactive
    case loading
    case loaded
    case failed(String)
    
    public var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    public var isLoaded: Bool {
        if case .loaded = self {
            return true
        }
        return false
    }
    
    public var errorMessage: String? {
        if case let .failed(value) = self {
            return value
        }
        return nil
    }
    
    mutating func setIsLoading() {
        self = .loading
    }
    
    mutating func setLoaded() {
        self = .loaded
    }
    
    mutating func setFailed(message: String) {
        self = .failed(message)
    }
    
}
