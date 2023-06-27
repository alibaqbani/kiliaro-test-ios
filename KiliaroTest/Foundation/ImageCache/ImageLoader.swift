//
//  ImageLoader.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import UIKit

protocol ImageLoadable {
    func load(url: URL?) async -> UIImage?
}

class ImageLoader: ImageLoadable {
    private let config: ImageLoaderConfig
    
    init(config: ImageLoaderConfig = .default) {
        self.config = config
    }
    
    @MainActor
    func load(url: URL?) async -> UIImage? {
        guard let url = url else {
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        
        if let cachedResponse = config.networkCache.cache(for: urlRequest),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        do {
            let (data, response) = try await config.networkSession.loadData(for: urlRequest)
            let cachedResponse = CachedURLResponse(response: response, data: data)
            config.networkCache.store(cachedResponse, for: urlRequest)
            return UIImage(data: data)
            
        } catch let error {
            print(error)
            return nil
        }
    }
}
