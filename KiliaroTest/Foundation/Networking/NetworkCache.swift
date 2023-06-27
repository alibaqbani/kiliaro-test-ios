//
//  NetworkCache.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/27/23.
//

import Foundation

protocol NetworkCache {
    func cache(for request: URLRequest) -> CachedURLResponse?
    func store(_ cachedResponse: CachedURLResponse, for request: URLRequest)
    func clear()
}

extension URLCache: NetworkCache {
    func cache(for request: URLRequest) -> CachedURLResponse? {
        return cachedResponse(for: request)
    }
    
    func store(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        storeCachedResponse(cachedResponse, for: request)
    }
    
    func clear() {
        removeAllCachedResponses()
    }
}
