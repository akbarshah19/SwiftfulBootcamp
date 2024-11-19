//
//  TransitionBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 7/9/24.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: CGFloat
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        .modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static func rotating(amount: CGFloat) -> AnyTransition {
        .modifier(
            active: RotateViewModifier(rotation: amount),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static var rotateOn: AnyTransition {
        .asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }
}

struct TransitionBootcamp: View {
    
    @State private var showRect = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRect {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Button("Animate") {
                withAnimation(.easeInOut(duration: 1)) {
                    showRect.toggle()
                }
            }
        }
    }
}

#Preview {
    TransitionBootcamp()
}
