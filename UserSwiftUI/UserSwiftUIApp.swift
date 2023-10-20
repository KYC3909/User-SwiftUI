//
//  UserSwiftUIApp.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 19/10/23.
//

import SwiftUI

@main
struct UserSwiftUIApp: App {
    let persistenceController = PersistanceStoreContainerFactory.create(with: .users, inMemory: false)
    
    @StateObject var userListViewModel = UserListViewModel(PersistanceUserCoreDataServiceManager())
    
    var body: some Scene {
        WindowGroup {
            UsersListView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
                .environmentObject(userListViewModel)
        }
    }
}
