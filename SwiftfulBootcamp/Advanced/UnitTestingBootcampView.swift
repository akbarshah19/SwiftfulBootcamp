//
//  UnitTestingBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 12/13/24.
//

import SwiftUI
import Combine

protocol DataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class MockDataService: DataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["One", "Two", "Three"]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}

class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    let dataService: DataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: DataServiceProtocol = MockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        dataArray.append(item)
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping {  [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellables)
    }
}

struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: false)
}
