//
//  CustomError.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import Foundation

enum RegistrationError: Error {
    case invalidEmail
    case invalidPassword
    case alreadyRegistered
    case userNotFound
}
extension RegistrationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Enter a valid email", comment: "Invalid Email")
        case .invalidPassword:
            return NSLocalizedString("Enter a valid password", comment: "Invalid Password")
        case .alreadyRegistered:
            return NSLocalizedString("This user is already registered, please try login", comment: "Invalid Phone Number")
        case .userNotFound:
            return NSLocalizedString("Invalid credentials, please try again", comment: "Invalid credentials")
        }
    }
}
