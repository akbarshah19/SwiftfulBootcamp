//
//  CoreDataBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/23/24.
//

import SwiftUI
import CoreData

class CoreDataBootcampVM: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading CoreData: ", error)
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching: ", error)
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        print("indexSet = ", indexSet)
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("Error saving: ", error)
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataBootcampVM()
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Add Fruit", text: $text)
                    .padding(.leading)
                    .font(.headline)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 16))
                
                Button {
                    guard !text.isEmpty else { return }
                    vm.addFruit(text: text)
                    text = ""
                } label: {
                    Text("Add")
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.orange)
                        .clipShape(.rect(cornerRadius: 16))
                }
                
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "No name")
                            .onTapGesture {
                                vm.updateFruit(entity: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
