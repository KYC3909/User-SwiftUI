//
//  PhoneNumberValidator.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation

class PhoneNumberValidator: ObservableObject, RegularExpressionProvider {
    
    @Published var text = ""
    @Published var passedValidation: ValidationStates = .notDetermined
    
    let message: String
    let regEx: String = "[0-9]{6,14}$"
    
    // Initialize with default message
    // use when need to show validation message
    init(_ message: String = "Please provide valid phone number with between 6-14 digits only") {
        self.message = message
    }
}

// Validation Provider Protocol
extension PhoneNumberValidator: ValidationProvider {
    
    // Validate Function to validate input
    func validate(_ value: String) -> String {
        passedValidation = .failed
        if value.isEmpty {
            return value
        }
        
        passedValidation = .failed
        let phoneRegEx = regEx
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        passedValidation = phonePred.evaluate(with: value)  ? .passed : .failed
        return value
    }
    
    func getErrorMessage() -> String {
        return message
    }
}
