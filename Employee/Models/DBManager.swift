//
//  DBManager.swift
//  Employee
//
//  Created by E5000861 on 17/06/24.
//

import UIKit
import CoreData
class DBManager {
    static let shared = DBManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Employee")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() -> [Employee] {
        var employees = [Employee]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        do {
            employees = try context.fetch(fetchRequest) as! [Employee]
        } catch {
            print("Error fetching data: \(error)")
        }
        return employees
    }
    
    func updateStudent(student: Employee, name: String, email: String) {
        student.name = name
        student.email = email
        saveContext()
    }
}
