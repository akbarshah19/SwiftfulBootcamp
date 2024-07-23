//
//  MatchedGeometryBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 7/23/24.
//

import SwiftUI

struct MatchedGeometryBootcamp: View {
    
    @State private var isClicked = false
    @Namespace private var animation
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "animation", in: animation)
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "animation", in: animation)
                    .frame(maxWidth: 200, maxHeight: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryBootcamp()
}
