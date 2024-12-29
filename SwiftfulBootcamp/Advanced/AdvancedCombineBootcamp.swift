//
//  AdvancedCombineBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 12/22/24.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    @Published var basicPublisher: [String] = []
    
    init() {
        publishFakeData()
    }
    
    func publishFakeData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.basicPublisher = ["One", "Two", "Three", "Four", "Five"]
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    var cancellables: Set<AnyCancellable> = []
    let dataService = AdvancedCombineDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$basicPublisher
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                }
//            } receiveValue: { [weak self] value in
//                self?.data = value
//            }
//            .store(in: &cancellables)
    }
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) { data in
                    Text(data)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
