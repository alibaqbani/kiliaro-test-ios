//
//  SharedMediaViewModel.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/27/23.
//

import Foundation

class SharedMediaViewModel: ObservableObject {
    
    @Published var selectedItem: SharedMediaItem? = nil
    @Published var errorMessage: String? = nil
    @Published var hasLoaded: Bool = false
    @Published var items: [SharedMediaItem] = []
    
    private let loader: SharedMediaLoadable
    private let sharedKey: String

    init(sharedKey: String, loader: SharedMediaLoadable) {
        self.sharedKey = sharedKey
        self.loader = loader
    }
    
    @MainActor
    func load(useCache: Bool = true) async {
        do {
            let result = try await loader.load(by: sharedKey, useCache: useCache)
            items = result
            
            if !hasLoaded { hasLoaded = true }
        } catch let error {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func retry() async {
        hasLoaded = false
        errorMessage = nil
        await load(useCache: false)
    }
}
