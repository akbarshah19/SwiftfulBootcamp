//
//  PropertyWrapperBootcamp2.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 5/6/25.
//

import SwiftUI

@propertyWrapper
struct Capitalized: DynamicProperty {
    
    @State private var value: String
    
    var wrappedValue: String {
        get {
            value
        }
        
        nonmutating set {
            value = newValue.capitalized
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

struct PropertyWrapperBootcamp2: View {
    
    @Capitalized private var title: String = "Hello, World!"
    
    var body: some View {
        Button {
            title = "new title"
        } label: {
            Text(title)
        }
    }
}

#Preview {
    PropertyWrapperBootcamp2()
}
