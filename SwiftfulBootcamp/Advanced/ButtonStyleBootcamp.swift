//
//  ButtonStyleBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 7/9/24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    //can use initializers
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
//            .opacity(configuration.isPressed ? 0.8 : 1)
//            .brightness(configuration.isPressed ? 0.1 : 0)
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Click")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color: .blue, radius: 10, x: 0.0, y: 10)
        }
        .buttonStyle(PressableButtonStyle())
        .padding()
    }
}

#Preview {
    ButtonStyleBootcamp()
}
