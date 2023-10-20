//
//  UserListViewModelProtocol.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import Foundation
import CoreData

protocol UserListViewModelProtocol {
    // Reset all fields
    func reset()
    
    // Create or Edit User Method
    func createUser()
    
    // Delete User Method
    func delete(_ user: User)
    
    /// `Method Dependency Injection`
    /// Store the User for User List View Model
    func editUser(_ user: User)
}
