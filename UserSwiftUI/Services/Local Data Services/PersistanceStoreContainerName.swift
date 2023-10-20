//
//  PersistanceStoreContainerName.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 17/10/23.
//

import Foundation
import CoreData

// Persistance Store Container Name
enum PersistanceStoreContainerName: String {
    case users = "Users"
}

// Factory Design Pattern class for Persistance Store Container
// Creates Persistent Container object
final class PersistanceStoreContainerFactory {
    
    // Factory Design Pattern to create Instance
    static func create(with type: PersistanceStoreContainerName, inMemory: Bool = true) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: type.rawValue)
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _,_ in }
        return container
    }
}
