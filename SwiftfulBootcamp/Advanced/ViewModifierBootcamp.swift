//
//  ViewModifierBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/30/24.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.red)
            .background(bgColor)
    }
}

extension View {
    func withDefaultButtonFormat(bgColor: Color) -> some View {
        self
            .modifier(DefaultButtonModifier(bgColor: bgColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .modifier(DefaultButtonModifier(bgColor: .blue))
            
            Text("Hello, World!")
                .withDefaultButtonFormat(bgColor: .blue)
        }
    }
}

#Preview {
    ViewModifierBootcamp()
}
