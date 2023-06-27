//
//  SharedMediaItemExtension.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/25/23.
//

import SwiftUI

extension SharedMediaItem {
    
    public func thumbnail(for hSizeClass: UserInterfaceSizeClass?, vSizeClass: UserInterfaceSizeClass?) -> String {
        let width: Int
        let height: Int
        
        switch (hSizeClass, vSizeClass) {
        case (.regular, .regular):
            (width, height) = (800, 800)
        case (.compact, .compact):
            (width, height) = (320, 320)
        default:
            (width, height) = (600, 600)
        }
        
        return "\(thumbnailUrl)?w=\(width)&h=\(height)&m=bb"
    }
}
