//
//  DragGestureBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/20/24.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        })
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder private func SignUpView() -> some View {
        VStack {
            Image(systemName: "chevron.compact.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 50)
            
            Text("Swipe Up to Sign Up")
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            
            Spacer()
            
            VStack {
                Image(systemName: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 150, maxHeight: 150)
                
                Button {
                    
                } label: {
                    Text("Sign up")
                        .padding()
                        .foregroundStyle(.orange)
                        .background(Color.black)
                        .clipShape(Capsule())
                }
            }
            .padding(.top, 50)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.15))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    DragGestureBootcamp()
}
