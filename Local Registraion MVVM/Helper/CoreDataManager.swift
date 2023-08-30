//
//  CoreDataManager.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        // pass the data model filename to NSPersistentContainer initializer
        persistentContainer = NSPersistentContainer(name: "Local_Registraion_MVVM")
      
        // load any persistent stores
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    // save the changes on your context to the persistent store
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllUser(entity:String) -> [User] {
        let request = NSFetchRequest<User>(entityName: entity)

        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}
