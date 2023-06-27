//
//  ImageLoaderConfig.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

struct ImageLoaderConfig {
    
    static let `default` = ImageLoaderConfig()
    
    var networkCache: NetworkCache = URLCache.shared
    
    var networkSession: NetworkSession = URLSession.shared
}
