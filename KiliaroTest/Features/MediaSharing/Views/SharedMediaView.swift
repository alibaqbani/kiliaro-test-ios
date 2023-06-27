//
//  SharedMediaView.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import SwiftUI

struct SharedMediaView: View {
        
    @Environment(\.mainWindowSize) private var windowSize
    
    @Namespace private var namespace
    @ObservedObject private var viewModel: SharedMediaViewModel
    
    @State private var blur = false
    @State private var viewId = 0
    
    init(viewModel: SharedMediaViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        let spacing = CGFloat(2)
        let width = (windowSize.width / 3) - spacing
        let height = width
        let columns = [GridItem(.adaptive(minimum: width, maximum: width), spacing: spacing)]
        
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(viewModel.items) { item in
                            if viewModel.selectedItem?.id != item.id {
                                ThumbnailView(item: item, namespace: namespace)
                                    .matchedGeometryEffect(id: item.id, in: namespace)
                                    .onTapGesture { performTapGesture(item) }
                            } else {
                                Color.clear.frame(width: width, height: height)
                            }
                        }
                    }
                    .id(viewId)
                }
                .refreshable {
                    await viewModel.load(useCache: false)
                    viewId += 1
                }
                .zIndex(1)
                .navigationTitle("Shared Media")
            }
            
            if blur {
                VisualEffectView(uiVisualEffect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(2)
            }
            
            presentDetailViewOnTap()
        }
        .overlay {
            if let message = viewModel.errorMessage {
                Color(UIColor.systemBackground).overlay {
                    VStack(spacing: 16) {
                        Text(message)
                            .multilineTextAlignment(.center)
                            .opacity(0.9)
                            .padding(24)
                        Button {
                            Task {
                                await viewModel.retry()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 28))
                        }
                    }
                }
            }
            else if !viewModel.hasLoaded {
                Color(UIColor.systemBackground).overlay { ProgressView() }
            }
        }
        .task {
            await viewModel.load()
        }
    }
    
    private func performTapGesture(_ item: SharedMediaItem) {
        withAnimation(.interactiveSpring(response: 0.35)) {
            if viewModel.selectedItem == nil {
                self.blur = true
                viewModel.selectedItem = item
            }
        }
    }
    
    @ViewBuilder
    private func presentDetailViewOnTap() -> some View {
        if let selectedItem = viewModel.selectedItem {
            Color.clear.overlay {
                SharedMediaItemView(item: selectedItem, namespace: namespace)
                    .matchedGeometryEffect(id: selectedItem.id, in: namespace)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation(.interactiveSpring(response: 0.35)) {
                        self.blur = false
                        self.viewModel.selectedItem = nil
                    }
                } label: {
                    Image(systemName: "multiply")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(8)
                        .background(Circle().fill(Color.black.opacity(0.5)))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
            }
            .zIndex(3)
        }
    }
}
