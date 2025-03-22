//
//  PropertyWrapperBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 3/22/25.
//

import SwiftUI

extension FileManager {
    static func documentsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    private let key: String
    
    var wrappedValue: String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            title = try String(contentsOf: FileManager.documentsPath(key: key), encoding: .utf8)
            print("Loaded!")
        } catch {
            title = wrappedValue
            print(error)
        }
    }
    
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentsPath(key: key), atomically: false, encoding: .utf8)
            title = newValue
            print("Success!")
//            print(NSHomeDirectory())
        } catch {
            print(error)
        }
    }
}

struct PropertyWrapperBootcamp: View {
    
    @FileManagerProperty("custom_title") var title = "Starting Text"
//    @State private var title: String = "Starting Value"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title).font(.largeTitle)
            
            Button("First") {
                title = "First Value"
//                fileManagerProperty.save(newValue: "First Value")
//                setTitle(newValue: "First Value")
            }
            
            Button("Second") {
                title = "Second Value"
//                fileManagerProperty.save(newValue: "Second Value")
//                setTitle(newValue: "Second Value")
            }
        }
        .onAppear {
//            fileManagerProperty.load()
            
//            do {
//                let savedValue = try String(contentsOf: fileURL, encoding: .utf8)
//                title = savedValue
//                print("Loaded!")
//            } catch {
//                print(error)
//            }
        }
    }
    
//    private func setTitle(newValue: String) {
//        let uppercased = newValue.uppercased()
//        title = uppercased
//        save(newValue: uppercased)
//    }
    
//    private var fileURL: URL {
//        FileManager.default
//            .urls(for: .documentDirectory, in: .userDomainMask)
//            .first!
//            .appending(path: "custom_title.txt")
//    }
    
//    private func save(newValue: String) {
//        do {
//            try newValue.write(to: fileURL, atomically: false, encoding: .utf8)
//            print("Success!")
//            print(NSHomeDirectory())
//        } catch {
//            print(error)
//        }
//    }
}

#Preview {
    PropertyWrapperBootcamp()
}
