//
//  WeakSelfBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/25/24.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                WeakSelfSecondScreen()
            } label: {
               Text("Navigate")
            }
            .navigationTitle("Screen 1")
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .padding()
                .font(.largeTitle)
                .background(Color.green)
                .clipShape(.rect(cornerRadius: 16))
                .padding()
        }
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenVM()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Screen 2")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenVM: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Initialize now")
        
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(count + 1, forKey: "count")
        
        getData()
    }
    
    deinit {
        
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(count - 1, forKey: "count")
        
        print("Deinitialize now")
    }
    
    func getData() {
        
        //Causes cycle retention
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
//            self.data = "New Data!"
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!"
        }
    }
}

#Preview {
    WeakSelfBootcamp()
}
