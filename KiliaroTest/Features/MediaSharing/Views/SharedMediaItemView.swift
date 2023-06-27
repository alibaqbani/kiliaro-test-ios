//
//  SharedMediaItemView.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/25/23.
//

import SwiftUI

struct SharedMediaItemView: View {
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass
    
    let item: SharedMediaItem
    let namespace: Namespace.ID
    
    var body: some View {
        Color.clear.overlay {
            VStack {
                let url = URL(string: item.thumbnail(for: hSizeClass, vSizeClass: vSizeClass))
                AsyncImage(url: url).aspectRatio(contentMode: .fill)
                HStack {
                    Text(item.createdAt, style: .date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white.opacity(0.9))
                        .matchedGeometryEffect(id: "date.\(item.id)", in: namespace)
                        .padding(4)
                    Text(item.size, format: .byteCount(style: .file, allowedUnits: .mb))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white.opacity(0.9))
                        .matchedGeometryEffect(id: "size.\(item.id)", in: namespace)
                        .padding(4)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
