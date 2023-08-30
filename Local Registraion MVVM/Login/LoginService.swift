//
//  LoginService.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import Foundation
import CoreData

protocol LoginApiHandler {
    func login(email:String,password:String,completionHandler: @escaping(Result<User?, Error>) -> ())
}

class LoginServiceLocalDatabase : LoginApiHandler {
    func login(email: String, password: String, completionHandler: @escaping (Result<User?, Error>) -> ()) {
        let users = CoreDataManager.shared.getAllUser(entity: "User")
        if let user = users.first(where: {$0.email == email && $0.password == password}){
            print(email + " exist")
            completionHandler(.success(user))
        } else {
            let error = RegistrationError.userNotFound
            completionHandler(.failure(error))
        }
    }
}

// If we want to use web service api instead of local data base then you can use below class
//class LoginService : LoginApiHandler {
//    func login(email: String, password: String, completionHandler: @escaping (Result<User?, Error>) -> ()) {
//        // API Call
//    }
//}
