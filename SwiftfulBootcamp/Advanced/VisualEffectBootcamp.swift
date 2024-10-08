//
//  VisualEffectBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 10/6/24.
//

import SwiftUI

struct VisualEffectBootcamp: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<50) { i in
                    Rectangle()
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .visualEffect { content, geometry in
                            content
                                .offset(x: geometry.frame(in: .global).minY * 0.05)
                        }
                }
            }
        }
    }
}

#Preview {
    VisualEffectBootcamp()
}
