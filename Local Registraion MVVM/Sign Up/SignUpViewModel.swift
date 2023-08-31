//
//  SignUpViewModel.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import Foundation

protocol SignUpViewModelProtocol:AnyObject {
    func userRegisteredSuccessfully() -> Void
    func failedToRegister(withErrorMessage errorMessage:String) -> Void
}
class SignUpViewModel {
    weak private var delegate:SignUpViewModelProtocol?
    private let signUpService: SignUpApiHandler = SignUpServiceLocalDatabase()
    typealias ValidationStatus = (status:Bool,errorMessage:String)
    
    init(withDelegate delegate:SignUpViewModelProtocol) {
        self.delegate = delegate
    }
    func signUp(firstName:String?,lastName:String?,gender:String?,mobile:String?,email:String?,password:String?) {
        
        // Validate first name
        var validationResult = self.validate(firstName: firstName)
        guard validationResult.status == true else {
            self.delegate?.failedToRegister(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Validate Email
        validationResult = self.validate(email: email)
        guard validationResult.status == true else {
            self.delegate?.failedToRegister(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.failedToRegister(withErrorMessage: validationResult.errorMessage)
            return
        }
        var userData = [String:String]()
        userData["firstName"] = firstName
        userData["lastName"] = lastName
        userData["gender"] = gender
        userData["mobile"] = mobile
        userData["email"] = email
        userData["password"] = password
        self.signUpService.register(user: userData, completionHandler: { result in
            
            switch result {
            case .success(_):
                self.delegate?.userRegisteredSuccessfully()
                debugPrint("User register successfully")
            case .failure(let error):
                self.delegate?.failedToRegister(withErrorMessage: error.localizedDescription)
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
        })
    }
}
// Validate your inputs
extension SignUpViewModel{
    func validate(email:String?) -> ValidationStatus {
        guard let emailValue = email,emailValue.isEmpty == false else {
            return (false,"Email should not be empty")
        }
        if emailValue.isValidEmail() == false{
            return (false,"Enter valid email")
        }
        return (true,"")
    }
    
    func validate(password:String?) -> ValidationStatus {
        guard let passwordValue = password, passwordValue.isEmpty == false else {
            return (false,"Password should not be empty")
        }
        return (true,"")
    }
    
    func validate(firstName:String?) -> ValidationStatus {
        guard let value = firstName, value.isEmpty == false else {
            return (false,"First name should not be empty")
        }
        return (true,"")
    }
}
