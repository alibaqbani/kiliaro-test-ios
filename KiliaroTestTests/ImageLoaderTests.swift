//
//  ImageLoaderTests.swift
//  KiliaroTestTests
//
//  Created by Ali Baqbani on 6/27/23.
//

import XCTest
@testable import KiliaroTest

class ImageLoaderTests: XCTestCase {

    func testLoadImageFromCache() async throws {
        // Create a mock network cache
        let mockNetworkCache = MockNetworkCache()
        
        // Create a mock network session
        let mockNetworkSession = MockNetworkSession()
        
        // Create a sample image data
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "test", ofType: "jpeg")!
        let data = try Data(contentsOf: URL(filePath: path))
        let pngImage = UIImage(data: data)?.pngData()
        
        // Create a sample URL and request
        let url = URL(string: "https://example.com/image.jpg")!
        let urlRequest = URLRequest(url: url)
        
        // Create a mock cached response and store it in the cache
        let cachedResponse = CachedURLResponse(response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: data)
        mockNetworkCache.store(cachedResponse, for: urlRequest)
        
        // Create an instance of ImageLoader with the mock cache and session
        let imageLoader = ImageLoader(config: ImageLoaderConfig(networkCache: mockNetworkCache, networkSession: mockNetworkSession))
        
        let imageData = await imageLoader.load(url: url)?.pngData()
        XCTAssertEqual(imageData, pngImage)
    }
    
    func testLoadImageFromNetwork() async throws {
        // Create a mock network cache
        let mockNetworkCache = MockNetworkCache()
        
        // Create a mock network session
        let mockNetworkSession = MockNetworkSession()
        
        // Create a sample image data
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "test", ofType: "jpeg")!
        let data = try Data(contentsOf: URL(filePath: path))
        let pngImage = UIImage(data: data)?.pngData()
        
        // Create a sample URL and request
        let url = URL(string: "https://example.com/image.jpg")!
        let urlRequest = URLRequest(url: url)
        
        // Get cachedResponse from network cache
        let cachedResponse = mockNetworkCache.cache(for: urlRequest)
        
        // Create an instance of ImageLoader with the mock cache and session
        let imageLoader = ImageLoader(config: ImageLoaderConfig(networkCache: mockNetworkCache, networkSession: mockNetworkSession))
        
        let imageData = await imageLoader.load(url: url)?.pngData()
        XCTAssertEqual(imageData, pngImage)
        XCTAssertEqual(cachedResponse?.data, nil)
    }
    
    func testInvalidateImageCache() async throws {
        // Create a mock network cache
        let mockNetworkCache = MockNetworkCache()
        
        // Create a mock network session
        let mockNetworkSession = MockNetworkSession()
        
        // Create a sample image data
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "test", ofType: "jpeg")!
        let data = try Data(contentsOf: URL(filePath: path))
        let pngImage = UIImage(data: data)?.pngData()
        
        // Create a sample URL and request
        let url = URL(string: "https://example.com/image.jpg")!
        let urlRequest = URLRequest(url: url)
        
        // Create a mock cached response and store it in the cache
        let cachedResponse = CachedURLResponse(response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: data)
        mockNetworkCache.store(cachedResponse, for: urlRequest)
        mockNetworkCache.clear()
        
        // Get cachedResponse from network cache
        let newCachedResponse = mockNetworkCache.cache(for: urlRequest)
        
        // Create an instance of ImageLoader with the mock cache and session
        let imageLoader = ImageLoader(config: ImageLoaderConfig(networkCache: mockNetworkCache, networkSession: mockNetworkSession))
        
        let imageData = await imageLoader.load(url: url)?.pngData()
        XCTAssertEqual(imageData, pngImage)
        XCTAssertEqual(newCachedResponse?.data, nil)
    }
    
    class MockNetworkSession: NetworkSession {
        func loadData(from url: URL) async throws -> Data {
            return Data()
        }
        
        func loadData(for request: URLRequest) async throws -> (Data, URLResponse) {
            
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "test", ofType: "jpeg")!
            let data = try Data(contentsOf: URL(filePath: path))
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
    }
    
    class MockNetworkCache: NetworkCache {
        
        private var cachedResponse: CachedURLResponse?
        
        func cache(for request: URLRequest) -> CachedURLResponse? {
            return cachedResponse
        }
        
        func store(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
            self.cachedResponse = cachedResponse
        }
        
        func clear() {
            cachedResponse = nil
        }
    }
}

