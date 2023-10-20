//
//  UserListView.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 19/10/23.
//

import SwiftUI

struct UsersListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userListVM:UserListViewModel
    
    // Fetch Request
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var fetchedUsers:FetchedResults<User>
    
    @State private var addView = false

    var body: some View {
        NavigationView{
            // Users List
            List(fetchedUsers, id: \.id) { user in
                UserView(user: user)
            }
            .sheet(isPresented: $addView){
                // Show User Creation View
                UserCreateView(addView: $addView, editing: false)
            }
            .toolbar{
                Button(action: {
                    // Toogle to Open User Creation View
                    userListVM.reset()
                    addView.toggle()
                }, label: {
                    Label("Add User",systemImage: "plus")
                })
            }
            .navigationTitle("Users")
        }.onAppear {
            
            // Update Managed Object Context
            /// `Method Dependency Injection`
            userListVM.updateMOC(viewContext)
        }

    }
}

#Preview {
    UsersListView()
}
