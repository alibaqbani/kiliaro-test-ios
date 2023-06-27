//
//  SharedMediaLoaderTests.swift
//  KiliaroTestTests
//
//  Created by Ali Baqbani on 6/27/23.
//

import XCTest
@testable import KiliaroTest

class SharedMediaLoaderTests: XCTestCase {
    
    func testLoadSharedMediaItems() async throws {
        // Create a mock network session
        let mockNetworkSession = MockNetworkSession()
        
        // Create a shared media loader with the mock network session
        let sharedMediaLoader = SharedMediaLoader(networkSession: mockNetworkSession)
        
        // Define the test data and expected results
        let sharedKey = "example_shared_key"
        
        // Perform the load operation
        let result = try await sharedMediaLoader.load(by: sharedKey)
        
        // Assert that the result matches the expected value
        XCTAssertEqual(result.count, 2)
    }
    
    func testLoadSharedMediaItemsWithInvalidSharedKey() async throws {
        // Create a mock network session
        let mockNetworkSession = MockNetworkSession()
        
        // Create a shared media loader with the mock network session
        let sharedMediaLoader = SharedMediaLoader(networkSession: mockNetworkSession)
        
        // Define an invalid shared key
        let invalidSharedKey = ""
        
        var didFailWithError: Error?
        do {
            // This call is expected to fail
            _ = try await sharedMediaLoader.load(by: invalidSharedKey)
        } catch {
            didFailWithError = error
            // Here you could do more assertions with the non-nil error object
        }
        
        XCTAssertNotNil(didFailWithError)
    }
    
    class MockNetworkSession: NetworkSession {
        func loadData(from url: URL) async throws -> Data {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "shared-media-data", ofType: "json")!
            let data = try Data(contentsOf: URL(filePath: path))
            return data
        }
        
        func loadData(for request: URLRequest) async throws -> (Data, URLResponse) {
            
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "shared-media-data", ofType: "json")!
            let data = try Data(contentsOf: URL(filePath: path))
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
    }
}
