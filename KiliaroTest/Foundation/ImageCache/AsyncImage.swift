//
//  AsyncImage.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import SwiftUI

struct AsyncImage: View {
    
    private let loader: ImageLoadable
    private let url: URL?
    
    @State private var image: UIImage?
    
    init(url: URL?, loader: ImageLoadable = ImageLoader()) {
        self.url = url
        self.loader = loader
    }
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Color.clear
            }
        }
        .task {
            image = await loader.load(url: url)
        }
    }
}
