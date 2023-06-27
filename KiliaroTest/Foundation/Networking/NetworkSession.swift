//
//  NetworkSession.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/27/23.
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL) async throws -> Data
    func loadData(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
    
    func loadData(for request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else
        {
            throw NetworkError.requestFailed
        }
        
        return (data, response)
    }
    
    func loadData(from url: URL) async throws -> Data {
        let (data, response) = try await data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else
        {
            throw NetworkError.requestFailed
        }
        
        return data
    }
}
