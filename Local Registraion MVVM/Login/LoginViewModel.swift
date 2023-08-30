//
//  LoginViewModel.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import Foundation
protocol LoginViewModelProtocol:AnyObject {
    func userLoggedInSuccessfully(user:User) -> Void
    func failedToLoggedIn(withErrorMessage errorMessage:String) -> Void
}
class LoginViewModel {
    weak private var delegate:LoginViewModelProtocol?
    private let loginService : LoginApiHandler = LoginServiceLocalDatabase()
    typealias ValidationStatus = (status:Bool,errorMessage:String)
    
    init(withDelegate delegate:LoginViewModelProtocol) {
        self.delegate = delegate
    }
    
    func login(withEmail email:String?,andPassword password:String?) -> Void {
        
        // Validate Email
        var validationResult = self.validate(email: email)
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        self.loginService.login(email: email ?? "", password: password ?? "", completionHandler: { result in
            
            switch result {
            case .success(let data):
                if let user = data {
                    self.delegate?.userLoggedInSuccessfully(user: user)
                }
                debugPrint("User logged in successfully")
            case .failure(let error):
                self.delegate?.failedToLoggedIn(withErrorMessage: error.localizedDescription)
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
        })
    }
}
// Validate your inputs
extension LoginViewModel{
    func validate(email:String?) -> ValidationStatus {
        guard let emailValue = email,emailValue.isEmpty == false else {
            return (false,"Enter email")
        }
        if emailValue.isValidEmail() == false{
            return (false,"Enter valid email")
        }
        return (true,"")
    }
    
    func validate(password:String?) -> ValidationStatus {
        guard let passwordValue = password, passwordValue.isEmpty == false else {
            return (false,"Enter password")
        }
        return (true,"")
    }
}

