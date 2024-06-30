//
//  PhotoModelDataService.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/17/24.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let shared = PhotoModelDataService()
    var cancellables = Set<AnyCancellable>()
    @Published var photoModels: [PhotoModel] = []
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: ", error)
                }
            } receiveValue: { [weak self] photoModels in
                self?.photoModels = photoModels
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
