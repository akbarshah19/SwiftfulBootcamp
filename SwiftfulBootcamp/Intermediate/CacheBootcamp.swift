//
//  CacheBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/10/24.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache.")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from cache.")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheBootcampVM: ObservableObject {
    
    let manager = CacheManager.instance
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName = "swift"
    
    init() {
        getImage()
    }
    
    func getImage() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

struct CacheBootcamp: View {
    @StateObject var vm = CacheBootcampVM()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No image")
                }
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No cached image")
                }
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to cache")
                            .padding()
                            .background(Color.black)
                            .clipShape(.capsule)
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from cache")
                            .padding()
                            .foregroundStyle(.red)
                            .background(Color.black)
                            .clipShape(.capsule)
                    }
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from cache")
                        .padding()
                        .foregroundStyle(.green)
                        .background(Color.black)
                        .clipShape(.capsule)
                }
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CacheBootcamp()
}
