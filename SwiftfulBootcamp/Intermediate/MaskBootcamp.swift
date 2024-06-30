//
//  MaskBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/21/24.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State private var rating: Int = 2
    
    var body: some View {
        VStack {
            StarsView()
                .overlay {
                    OverlayView()
                        .mask(StarsView())
                }
        }
        .padding()
    }
    
    @ViewBuilder private func OverlayView() -> some View {
        GeometryReader { geo in
            Rectangle()
                .frame(width: CGFloat(rating) / 5 * geo.size.width)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.yellow, Color.orange, Color.red],
                        startPoint: .leading,
                        endPoint: .trailing)
                )
        }
        .allowsHitTesting(false)
    }
    
    @ViewBuilder private func StarsView() -> some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
