//
//  CombineBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/30/24.
//

import SwiftUI
import Combine

struct CombineModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class CombineBootcampVM: ObservableObject {
    
    @Published var posts: [CombineModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [CombineModel].self, decoder: JSONDecoder())
//            .replaceError(with: [])
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("failure: ", error)
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}

struct CombineBootcamp: View {
    
    @StateObject var vm = CombineBootcampVM()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                    Text(post.body)
                }
            }
        }
    }
}

#Preview {
    CombineBootcamp()
}
