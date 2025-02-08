//
//  CustomBindingsBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 2/8/25.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}

struct CustomBindingsBootcamp: View {
    
    @State private var errorTitle: String? = nil
    
    var body: some View {
        Button("Click") {
            errorTitle = "Error"
        }
        .alert("Error Alert", isPresented: Binding(value: $errorTitle)) {
            
        }
    }
}

#Preview {
    CustomBindingsBootcamp()
}
