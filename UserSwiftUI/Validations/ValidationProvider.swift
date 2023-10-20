//
//  ValidationProvider.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation

// Validation Protocol
// Follows 
// Single Reponsibility Principle
// Open Closed Principle
protocol ValidationProvider {
    var text: String { get set }
    var message: String { get }
    var passedValidation: ValidationStates { get set }
    func validate(_ value: String) -> String
    func getErrorMessage() -> String
}

protocol RegularExpressionProvider {
    var regEx: String { get }
}
