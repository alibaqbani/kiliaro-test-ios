//
//  SharedMediaLoader.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/25/23.
//

import Foundation

protocol SharedMediaLoadable {
    
    func load(by sharedKey: String, useCache: Bool) async throws -> [SharedMediaItem]
}

class SharedMediaLoader: SharedMediaLoadable {
    
    private let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func load(by sharedKey: String, useCache: Bool = true) async throws -> [SharedMediaItem] {
        
        try validate(sharedKey: sharedKey)
        
        guard let request = SharedMediaRequest.list(sharedKey).build(useCache: useCache) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await networkSession.loadData(for: request)
        return try data.map(type: [SharedMediaItem].self)
    }
    
    private func validate(sharedKey: String) throws {
        if sharedKey.isEmpty {
            throw ValidationError.invalidSharedKey
        }
    }
}
