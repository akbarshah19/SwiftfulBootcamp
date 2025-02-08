//
//  FuturesBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 2/8/25.
//

import SwiftUI
import Combine

class FuturesBootcampViewModel: ObservableObject {
    
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.com")
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
        
//        getEscapingClosure() { [weak self] value, error in
//            self?.title = value
//        }
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url!)
            .timeout(10, scheduler: DispatchQueue.main)
            .map { _ in
              return "New Value"
            }
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completion: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url!) { data, response, error in
            completion("New Value 2", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { value, error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
    }
}

struct FuturesBootcamp: View {
    
    @StateObject private var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesBootcamp()
}
