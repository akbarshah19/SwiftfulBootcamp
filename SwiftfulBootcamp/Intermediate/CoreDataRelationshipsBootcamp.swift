//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/24/24.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error loading CoreData: ", error)
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving CoreData: ", error)
        }
    }
}

class CoreDataRelationshipsBootcampVM: ObservableObject {
    let manager = CoreDataManager.shared
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)]
//        request.predicate = NSPredicate(format: "name == %@", "Apple")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching: ", error)
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Error fetching: ", error)
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching: ", error)
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Microsoft"
        
        newBusiness.departments = [departments[0], departments[1]]
        
        newBusiness.employees = [employees[2]]
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Engineering"
//        newDepartment.businesses = [businesses[0]]
        
        newDepartment.addToEmployees(employees[2])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 35
        newEmployee.dateJoined = Date()
        newEmployee.name = "John"
        
//        newEmployee.business = businesses[0]
//        newEmployee.department = departments[0]
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
    func deleteDepartment() {
        //nullify, cascade, deny
        
        let dept = departments[1]
        manager.context.delete(dept)
        save()
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsBootcampVM()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 52)
                            .foregroundStyle(.white)
                            .background(Color.black)
                            .clipShape(Capsule())
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { dept in
                                DepartmentView(entity: dept)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    
    var entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "empty_name")")
                .bold()
            
            if let depts = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()
                
                ForEach(depts) { dept in
                    Text(dept.name ?? "empty_dept_name")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "empty_employee_name")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.4))
        .shadow(radius: 10)
        .clipShape(.rect(cornerRadius: 12))
    }
}

struct DepartmentView: View {
    
    var entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "empty_name")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()
                
                ForEach(businesses) { business in
                    Text(business.name ?? "empty_business_name")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "empty_employee_name")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.green.opacity(0.4))
        .shadow(radius: 10)
        .clipShape(.rect(cornerRadius: 12))
    }
}

struct EmployeeView: View {
    
    var entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "empty_name")")
                .bold()
            
            Text("Age: \(entity.age)")
            
            Text("Joined: \(entity.dateJoined ?? .now)")
            
            Text("Business: ")
                .bold()
            
            Text(entity.business?.name ?? "empty_business_name")
            
            Text("Department: ")
                .bold()
            
            Text(entity.department?.name ?? "empty_department_name")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.4))
        .shadow(radius: 10)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}
