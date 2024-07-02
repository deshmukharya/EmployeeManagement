//
//  Student+CoreDataProperties.swift
//  Employee
//
//  Created by E5000861 on 17/06/24.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var email: String?

}

extension Employee : Identifiable {

}
