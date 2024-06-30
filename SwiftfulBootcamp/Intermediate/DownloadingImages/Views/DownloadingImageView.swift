//
//  DownloadingImageView.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/17/24.
//

import SwiftUI
import Combine

class DownloadingImageVM: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    let manager = PhotoModelCacheManager.shared
    var cancellables = Set<AnyCancellable>()
    var imageUrl: String
    var imageKey: String
    
    init(imageUrl: String, key: String) {
        self.imageUrl = imageUrl
        self.imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image.")
        } else {
            downloadImage()
            print("Downloading image.")
        }
    }
    
    func downloadImage() {
        print("Downloading images now.")
        isLoading = true
        guard let url = URL(string: imageUrl) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard
                    let strongSelf = self,
                    let image = image else {
                    return
                }
                strongSelf.image = image
                strongSelf.manager.add(key: strongSelf.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}

struct DownloadingImageView: View {
    
    
    @StateObject var vm: DownloadingImageVM
    
    init(url: String, key: String) {
        _vm = StateObject(wrappedValue: DownloadingImageVM(imageUrl: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(.circle)
            } else {
                Circle()
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
}
