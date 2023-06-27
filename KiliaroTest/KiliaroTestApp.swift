//
//  KiliaroTestApp.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/23/23.
//

import SwiftUI

@main
struct KiliaroTestApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                SharedMediaView(
                    viewModel: .init(
                        sharedKey: "djlCbGusTJamg_ca4axEVw",
                        loader: SharedMediaLoader(networkSession: URLSession.shared)
                    )
                )
                .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
