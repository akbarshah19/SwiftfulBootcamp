//
//  GeometryReaderBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/20/24.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 12)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geo) * 15),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 300)
                    .padding()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func getPercentage(geo: GeometryProxy) -> CGFloat {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return 1 - (currentX / maxDistance)
    }
}

#Preview {
    GeometryReaderBootcamp()
}
