//
//  String+Extension.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let strPasswordValue = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strPasswordValue.count >= 8
    }
}
