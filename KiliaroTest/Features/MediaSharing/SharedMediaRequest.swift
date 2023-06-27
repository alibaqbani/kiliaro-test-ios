//
//  SharedMediaTarget.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

enum SharedMediaRequest {
    case list(String)
}

extension SharedMediaRequest: Request {
    var baseUrl: String {
        "https://api1.kiliaro.com"
    }
    
    var path: String {
        switch self {
        case .list(let sharedKey):
            return "/shared/\(sharedKey)/media"
        }
    }
    
    var method: HTTPMethod { .get }
}
