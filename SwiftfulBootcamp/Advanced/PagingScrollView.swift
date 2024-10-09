//
//  PagingScrollView.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 10/9/24.
//

import SwiftUI

struct PagingScrollView: View {
    
    @State private var horizontal = true
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        ZStack {
            if horizontal {
                Horizontal()
            } else {
                Vertical()
            }
        }
    }
    
    @ViewBuilder
    private func Horizontal() -> some View {
        VStack {
            Button("Scroll to") {
                scrollPosition = (0..<20).randomElement()
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<20) { i in
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .cornerRadius(8)
                            .overlay {
                                Text("\(i+1) element")
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .id(i)
                            .scrollTransition(.interactive.threshold(.visible(0.3))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
                    }
                }
                .padding(.vertical, 100)
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.smooth, value: scrollPosition)
        }
    }
    
    @ViewBuilder
    private func Vertical() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<20) { i in
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("\(i+1) element")
                                .foregroundStyle(.white)
                        }
                        .containerRelativeFrame(.vertical, alignment: .center)
                }
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    PagingScrollView()
}
