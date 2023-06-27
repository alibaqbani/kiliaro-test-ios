//
//  Response.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

struct Response {
    
    let data: Data
}

extension Response {
    
    func map<T>(type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Decodable {
        return try decoder.decode(T.self, from: data)
    }
}
