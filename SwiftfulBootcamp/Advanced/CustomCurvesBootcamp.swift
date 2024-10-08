//
//  CustomShape2Bootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 7/24/24.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        ShapeWithArc()
            .frame(maxWidth: 300, maxHeight: 300)
    }
}

#Preview {
    CustomCurvesBootcamp()
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.midX, y: rect.midY))
            path.addArc(
                center: .init(x: rect.midX, y: rect.midY),
                radius: rect.height/2,
                startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: false
            )
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            //top left
            path.move(to: .init(x: rect.minX, y: rect.minY))
            
            //top right
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            
            //mid right
            path.addLine(to: .init(x: rect.maxX, y: rect.midY))
            
            //bottom
            path.addArc(
                center: .init(x: rect.midX, y: rect.midY),
                radius: rect.height/2,
                startAngle: .degrees(0),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            //mid left
            path.addLine(to: .init(x: rect.minX, y: rect.midY))
        }
    }
}
