//
//  DataService.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 17/10/23.
//

import Foundation


/// Supported CRUD Types = `Added` or `Deleted`
/// This is useful when `User` will be `fetch`, `Add`, `Update` or `Delete`
enum User_CRUD_Type: Int {
    case fetch, add, update, delete
}


protocol LocalDataServiceProvider {
    // Associated Type (Entity, Model) Object
    associatedtype EntityObj
        
    // Save (Add/Edit) EntityObj Object to Local Storage
    func addUser(_ name: String,
                 _ email: String,
                 _ phone: String,
                 _ country: String,
                 _ countryCode: String,
                 _ flagEmoji: String
    )
    
    // Save (Add/Edit) EntityObj Object to Local Storage
    func editUser(_ user: User,
                  _ name: String,
                  _ email: String,
                  _ phone: String,
                  _ country: String,
                  _ countryCode: String,
                  _ flagEmoji: String
    ) 
    
    // Delete EntityObj Object from Local Storage
    func delete(_ user: EntityObj)
}
