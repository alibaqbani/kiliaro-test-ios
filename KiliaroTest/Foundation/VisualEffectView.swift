//
//  VisualEffectView.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/26/23.
//

import SwiftUI

/// A view used to blur the grid, using a UIViewRepresentable of UIKit's UIVisualEffect
struct VisualEffectView: UIViewRepresentable {
    var uiVisualEffect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = uiVisualEffect
    }
}
