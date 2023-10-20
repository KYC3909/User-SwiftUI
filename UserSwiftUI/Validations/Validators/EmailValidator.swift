//
//  EmailValidator.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation

class EmailValidator: ObservableObject, RegularExpressionProvider {

    @Published var text = ""
    @Published var passedValidation: ValidationStates = .notDetermined
    
    let message: String
    let regEx: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    // Initialize with default message
    // use when need to show validation message
    init(_ message: String = "Please provide valid email") {
        self.message = message
    }
}

// Validation Provider Protocol
extension EmailValidator: ValidationProvider {
    
    // Validate Function to validate input
    func validate(_ value: String) -> String {
        if value.isEmpty {
            passedValidation = .failed
            return value
        }
        let emailRegEx = regEx
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        passedValidation = emailPred.evaluate(with: value)  ? .passed : .failed
        return value
    }
    
    func getErrorMessage() -> String {
        return message
    }
}
