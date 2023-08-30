//
//  SignUpService.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import Foundation
import CoreData

protocol SignUpApiHandler {
    func register(user:[String:String],completionHandler: @escaping(Result<User?, Error>) -> ())
}
class SignUpServiceLocalDatabase {
    func save (user:[String:String]) {
        let userData = User(context: CoreDataManager.shared.viewContext)
        userData.id = UUID()
        userData.firstName = user["firstName"]
        userData.lastName = user["lastName"]
        userData.gender = user["gender"]
        userData.mobile = user["mobile"]
        userData.email = user["email"]
        userData.password = user["password"]
        CoreDataManager.shared.saveContext()
    }
}
extension SignUpServiceLocalDatabase : SignUpApiHandler {
    func register(user: [String:String], completionHandler: @escaping (Result<User?, Error>) -> ()) {
        let users = CoreDataManager.shared.getAllUser(entity: "User")
        if let userResult = users.first(where: {$0.email == user["email"]}){
            print((userResult.email ?? "") + " exist")
            let error = RegistrationError.alreadyRegistered
            completionHandler(.failure(error))
        } else {
            save(user: user)
            completionHandler(.success(nil))
        }
    }
}

// If we want to use web service api instead of local data base then you can use below class
//class SignUpService : SignUpApiHandler {
//    func register(user: User, completionHandler: @escaping (Result<User?, Error>) -> ()) {
//        // API Call
//    }
//}
