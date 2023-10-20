//
//  PersistanceUserCoreDataServiceManager.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 17/10/23.
//

import Foundation
import CoreData

class PersistanceUserCoreDataServiceManager {
    // Associated Type (Entity, Model) Object
    typealias EntityObj = User
    
    // ManagedObjectContext
    private(set) var context: NSManagedObjectContext!
    
    /// `Method Dependency Injection`
    func storeMOC(_ context: NSManagedObjectContext) {
        self.context = context
    }
}

//MARK: - Protocol Local DataService Provider methods

extension PersistanceUserCoreDataServiceManager: LocalDataServiceProvider {
    
    /// Save (Add/Edit) `User` Object to Local Storage
    func addUser(_ name: String,
                 _ email: String,
                 _ phone: String,
                 _ country: String,
                 _ countryCode: String,
                 _ flagEmoji: String
    ){
        let user = User(context: context)
        user.id = UUID()
        user.name = name
        user.email = email
        user.phone = phone
        user.country = country
        user.countryCode = countryCode
        user.flagEmoji = flagEmoji
        user.date = Date()
        
        save(context: context)
    }
    
    /// Save (Add/Edit) `User` Object to Local Storage
    func editUser(_ user: User,
                  _ name: String,
                  _ email: String,
                  _ phone: String,
                  _ country: String,
                  _ countryCode: String,
                  _ flagEmoji: String
    ) {
        
        let userItem = user
        userItem.name = name
        userItem.email = email
        userItem.phone = phone
        userItem.country = country
        userItem.countryCode = countryCode
        userItem.flagEmoji = flagEmoji
        userItem.date = Date()
        
        save(context: context)
    }
    
   
    /// Delete `User` Object to Local Storage
    func delete(_ user: User) {
        context.delete(user)
        save(context: context)
    }
    
}

//MARK: - Private Helper methods
extension PersistanceUserCoreDataServiceManager {
    
    // Save Record to Context
    private func save(context:NSManagedObjectContext){
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
}

