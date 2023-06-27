//
//  DataExtension.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/25/23.
//

import Foundation

extension Data {
    
    func map<T>(type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Decodable {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        })
        
        return try decoder.decode(T.self, from: self)
    }
}

