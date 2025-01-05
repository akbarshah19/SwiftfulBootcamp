//
//  AdvancedCombineBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 12/22/24.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
//    @Published var basicPublisher: String = "First Value"
//    let currentValuePublisher = CurrentValueSubject<String, Error>("First Value")
    let passThroughtPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    func publishFakeData() {
        let items: [Int] = Array(0...10)
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
//                self.basicPublisher = items[x]
                self.passThroughtPublisher.send(items[x])
                
                if x == items.indices.last {
                    self.passThroughtPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = ""
    var cancellables: Set<AnyCancellable> = []
    let dataService = AdvancedCombineDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.passThroughtPublisher
        //Sequence opertaions
            //.first()
            //.first(where: { $0 > 4 })
            //.tryFirst(where: { int in
            //if int == 3 {
            //  throw URLError(.badServerResponse)
            //}
            //return int > 4
            //})
            //.last()
            //.last(where: { $0 < 4 })
            //.tryLast(where: { int in
            //    if int == 3 {
            //      throw URLError(.badServerResponse)
            //    }
            //    return int > 4
            //})
            //.dropFirst()
            //.drop(while: { $0 == 0})
            //.drop(while: { $0 > 5 })
            //.tryDrop(while: { int in
            //    if int == 3 {
            //      throw URLError(.badServerResponse)
            //    }
            //    return int > 4
            //})
            //.removeDuplicates()
            //.replaceNil(with: 5)
            //.scan(0, { exitingValue, newValue in
            //    return exitingValue + newValue
            //})
            //.scan(0, { $0 + $1 })
            //.scan(0, +)
            //.reduce(0, +)
        
            .map { String($0) }
            //.collect()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] value in
                self?.data.append(value)
            }
            .store(in: &cancellables)
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
                
                if !vm.error.isEmpty {
                    Text(vm.error)
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
