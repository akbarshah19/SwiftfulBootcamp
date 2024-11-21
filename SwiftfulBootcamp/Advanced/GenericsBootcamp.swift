//
//  GenericsBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 11/21/24.
//

import SwiftUI

struct GenericsView<T: View>: View {
    let content: T
    
    var body: some View {
        content
    }
}

struct GenericsBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        GenericsView(content: Text("GenericsView"))
    }
}

#Preview {
    GenericsBootcamp()
}
