//
//  CustomShapeBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 7/23/24.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.midX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let hOffset: CGFloat = rect.width * 0.2
            path.move(to: .init(x: rect.midX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX - hOffset, y: rect.midY))
            path.addLine(to: .init(x: rect.midX, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX + hOffset, y: rect.midY))
            path.addLine(to: .init(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomShapeBootcamp: View {
    var body: some View {
        Diamond()
            .frame(maxWidth: 300, maxHeight: 300)
    }
}

#Preview {
    CustomShapeBootcamp()
}
