//
//  UserListViewModel.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation
import Combine
import CoreData

class UserListViewModel:ObservableObject{
    
    private(set) var textValidator = TextValidator()
    private(set) var emailValidator = EmailValidator()
    private(set) var phoneValidator = PhoneNumberValidator()
    
    private(set) var persistanceUserCoreDataServiceManager: PersistanceUserCoreDataServiceManager
    
    private(set) var editingMode = false

    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var country = ""
    @Published var countryCode = ""
    @Published var flagEmoji = ""
    
    @Published var userItem:User! {
        didSet{
            name = userItem.name ?? ""
            email = userItem.email ?? ""
            phone = userItem.phone ?? ""
            country = userItem.country ?? ""
            countryCode = userItem.countryCode ?? ""
            flagEmoji = userItem.flagEmoji ?? ""
            updateValidators()
        }
    }
    
    // Initialize PersistanceUserCoreDataServiceManager
    init(_ persistanceUserCoreDataServiceManager: PersistanceUserCoreDataServiceManager){
        self.persistanceUserCoreDataServiceManager = persistanceUserCoreDataServiceManager
    }
    
}

extension UserListViewModel: UserListViewModelProtocol {
    /// `Method Dependency Injection`
    func updateMOC(_ context: NSManagedObjectContext){
        self.persistanceUserCoreDataServiceManager.storeMOC(context)
    }
    
    // Update Validators for Validations
    func updateValidators() {
        _ = textValidator.validate(name)
        _ = emailValidator.validate(email)
        _ = phoneValidator.validate(phone)
    }
    
    // Set Editing or Adding User Item to Database
    /// `Method Dependency Injection`
    func enableEditing(_ editMode: Bool) {
        editingMode = editMode
    }
    
    // Reset all fields
    func reset() {
        name = ""
        email = ""
        phone = ""
        country = ""
        countryCode = ""
        flagEmoji = ""
        updateValidators()
    }
    
    // Create or Edit User Method and
    // passed responsibility to `PersistanceUserCoreDataServiceManager`
    func createUser(){

        if !editingMode {
//            let user = User(context: context)
//            user.id = UUID()
//            user.name = name
//            user.email = email
//            user.phone = phone
//            user.country = country
//            user.countryCode = countryCode
//            user.flagEmoji = flagEmoji
//            user.date = Date()
            
            self.persistanceUserCoreDataServiceManager.addUser(name,
                                                               email,
                                                               phone,
                                                               country,
                                                               countryCode,
                                                               flagEmoji
            )
        }
        else{
            
//            userItem.name = name
//            userItem.email = email
//            userItem.phone = phone
//            userItem.country = country
//            userItem.countryCode = countryCode
//            userItem.flagEmoji = flagEmoji
//            userItem.date = Date()
            
            self.persistanceUserCoreDataServiceManager.editUser(userItem,
                                                                name,
                                                                email,
                                                                phone,
                                                                country,
                                                                countryCode,
                                                                flagEmoji
            )
            
        }
        
//        save(context: context)
        
        reset()
    }
    
    // Delete User Method and
    // passed responsibility to `PersistanceUserCoreDataServiceManager`
    func delete(_ user: User){
//        context.delete(user)
//        save(context: context)

        self.persistanceUserCoreDataServiceManager.delete(user)
    }
    
    /// `Method Dependency Injection`
    /// Store the User for User List View Model
    func editUser(_ user: User){
        self.userItem = user
    }

}
