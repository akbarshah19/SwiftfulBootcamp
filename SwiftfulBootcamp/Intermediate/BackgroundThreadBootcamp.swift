//
//  BackgroundThreadBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/25/24.
//

import SwiftUI

class BackgroundThreadBootcampVM: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Is main thread: \(Thread.isMainThread)")
            print("Current thread: \(Thread.current)")
            
            DispatchQueue.main.async {
                print("Is main thread: \(Thread.isMainThread)")
                print("Current thread: \(Thread.current)")
                
                self.dataArray = newData
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for i in 0..<100 {
            data.append("\(i)")
        }
        
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadBootcampVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button {
                    vm.fetchData()
                } label: {
                    Text("Load data".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
