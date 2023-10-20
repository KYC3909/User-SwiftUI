//
//  TextValidator.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation

class TextValidator: ObservableObject {
    
    @Published var text = ""
    @Published var passedValidation: ValidationStates = .notDetermined
    let message: String
    
    // Initialize with default message
    // use when need to show validation message
    init(_ message: String = "Please provide valid name") {
        self.message = message
    }
}

// Validation Provider Protocol
extension TextValidator: ValidationProvider {
    
    // Validate Function to validate input
    func validate(_ value: String) -> String {
        passedValidation = value.isEmpty ? .failed : .passed
        return value
    }
    
    func getErrorMessage() -> String {
        return message
    }
}
