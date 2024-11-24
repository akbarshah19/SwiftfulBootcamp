//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 11/23/24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "Title"
    @State private var scrollViewOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(Double(scrollViewOffset)/78.0)
                    .background {
                        GeometryReader { geo in
                            Text("")
                                .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                        }
                    }
                
                ForEach(0..<50) { _ in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.green)
                        .frame(height: 200)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .overlay(Text("\(scrollViewOffset)"))
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollViewOffset = value
        }
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}
