//
//  RequestProtocol.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

protocol Request {
    var baseUrl : String { get }
    var path : String { get }
    var method : HTTPMethod { get }
    var headers: [String: String]? { get }
}

extension Request {
    var headers: [String : String]? { return nil }
}

extension Request {
    
    func build(useCache: Bool = true) -> URLRequest? {
        build(cachePolicy: useCache ? .returnCacheDataElseLoad : .reloadIgnoringLocalCacheData)
    }
    
    func build(cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad) -> URLRequest? {
        guard let url = buildUrl(baseUrl, path: path) else {
            return nil
        }
        
        return URLRequest(url: url, cachePolicy: cachePolicy)
    }
    
    private func buildUrl(_ baseURL: String, path: String) -> URL? {
        guard let baseURL = URL(string: baseURL) else {
            return nil
        }
        
        let url = URL(string: path, relativeTo: baseURL)
        return url
    }
}

