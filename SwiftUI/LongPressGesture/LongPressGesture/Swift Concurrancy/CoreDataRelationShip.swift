//
//  CoreDataRelationShip.swift
//  LongPressGesture
//
//  Created by mac on 02/04/24.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name :"CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error in loading Core Data.. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
        }catch let error {
            print("Error saving Core Data.\(error.localizedDescription)")
        }
    }
    
    
    
}

class CoreDataRelationShipViewModel : ObservableObject {
    let manager = CoreDataManager.instance
    @Published var businesses : [BusinessEntity] = []
    @Published var departments : [DepartmentEntity] = []
    @Published var employees : [EmployeeEntity] = []
    
    init()
    {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        
        //add Existing departments to a new business
//        newBusiness.departments = []
        
        //add existing employees to a new business
//        newBusiness.employees = []
        
        //add new business to existing department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        //add new business to existing employees
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartments(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func addEmployees(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Jsy"
        newEmployee.age = 30
        newEmployee.dateJoined = Date()
//        newEmployee.business = businesses[0]
//        newEmployee.department = departments[0]
        save()
    }
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do{
            businesses = try manager.context.fetch(request)
        }catch let error {
            print("Error in fetching... \(error)")
        }
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        }catch let error {
            print("Error in fetching... \(error)")
        }
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        }catch let error {
            print("Error in fetching... \(error)")
        }
    }
    
    func save(){
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
    
}


struct CoreDataRelationShip: View {
    
    @StateObject var vm = CoreDataRelationShipViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing : 20)
                {
                    Button {
                        vm.addEmployees()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height : 55)
                            .frame(maxWidth : .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                    BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                    DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                    EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Relationships")
        }
    }
}


struct BusinessView : View {
    
    let entity : BusinessEntity
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Name : \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments : ")
                    .bold()
                ForEach(departments){ department in
                    
                    Text(department.name ?? "")
                    
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees : ")
                    .bold()
                ForEach(employees){ employee in
                    
                    Text(employee.name ?? "")
                    
                }
            }
            
            
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        
    }
    
}


struct DepartmentView : View {
    
    let entity : DepartmentEntity
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Name : \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses : ")
                    .bold()
                ForEach(businesses){ businesse in
                    
                    Text(businesse.name ?? "")
                    
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees : ")
                    .bold()
                ForEach(employees){ employee in
                    
                    Text(employee.name ?? "")
                    
                }
            }
            
            
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        
    }
    
}

struct EmployeeView : View {
    
    let entity : EmployeeEntity
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Name : \(entity.name ?? "")").bold()
            Text("Age : \(entity.age)").bold()
            Text("Date : \(entity.dateJoined ?? Date())").bold()
            
            Text("Department : ")
                .bold()
            Text(entity.department?.name ?? "")

            
            Text("Business : ")
                .bold()
            Text(entity.business?.name ?? "")
            
            
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        
    }
    
}

struct CoreDataRelationShip_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationShip()
    }
}
