//
//  User+CoreDataProperties.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var password: String?
    @NSManaged public var id: UUID?

}

extension User : Identifiable {

}
