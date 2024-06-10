//
//  FileManagerBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/8/24.
//

import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    let folderName = "MyApp_Images"
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
        else {
            print("Error creating path.")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch {
                print("Error creating directory: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
        else {
            print("Error creating path.")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Folder deleted.")
        } catch {
            print("Error deleting folder: \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) {
        //image.pngData() for png images
        guard 
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name)
        else {
            print("Error getting data.")
            return
        }
                
        do {
            try data.write(to: path)
            print("Saved.")
        } catch {
            print("Error saving: ", error)
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting path.")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("File deleted.")
        } catch {
            print("Error removing item: \(error)")
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg", conformingTo: .jpeg)
        else {
            print("Error getting the path.")
            return nil
        }
        
        return path
    }
}

class FileManagerVM: ObservableObject {
    
    @Published var image: UIImage?
    let imageName: String = "swift"
    
    init() {
//        getImage()
        getImageFromFM()
    }
    
    func getImage() {
        DispatchQueue.main.async { [weak self] in
            guard let name = self?.imageName else { return }
            self?.image = UIImage(named: name)
        }
    }
    
    func getImageFromFM() {
        image = LocalFileManager.shared.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        LocalFileManager.shared.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        LocalFileManager.shared.deleteImage(name: imageName)
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No image")
                }
                
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save to FM")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.blue)
                }
                
                Button {
                    vm.deleteImage()
                } label: {
                    Text("Delete from FM")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.blue)
                }
            }
            .padding()
        }
        .navigationTitle("File Manager")
    }
}

#Preview {
    NavigationStack {
        FileManagerBootcamp()
    }
}
