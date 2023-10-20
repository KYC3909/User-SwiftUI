//
//  UserView.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 14/10/23.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var userListViewModel:UserListViewModel
    
    @ObservedObject var user:User
    
    @State private var isEdit = false
    
    var body: some View {
        
        Button {
            // Editing View
            userListViewModel.reset()
            userListViewModel.userItem = user
            isEdit.toggle()
            
        } label: {
            VStack(alignment: .leading) {
                
                // Name
                CustomText(text: user.name ?? "N/A")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .lineLimit(.max)
                
                // Email
                CustomText(text: user.email ?? "N/A")
                    .frame(alignment: .leading)
                    .foregroundStyle(.secondary)
                
                HStack{
                    // Flag Emoji
                    if !(user.flagEmoji ?? "").isEmpty {
                        CustomText(text: user.flagEmoji ?? "N/A")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                    }
                    
                    // Country Code
                    CustomText(text: user.countryCode ?? "N/A")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                        .foregroundStyle(.secondary)
                    
                    // Phone
                    CustomText(text: user.phone ?? "N/A")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
            }
            .tint(.primary)
            
        }
        .sheet(isPresented: $isEdit){
            // Show User Creation View
            UserCreateView(addView: $isEdit, editing: true)
        }
        
        /// Swipe Action to `Edit` and `Delete`
        .swipeActions(edge: .trailing, allowsFullSwipe: false){
            
            /// Swipe Action to ``Delete``
            Button(role: .destructive, action: {
                userListViewModel.delete(user)
            }, label: {
                Label("Delete",systemImage: "trash")
            })
            
            /// Swipe Action to ``Edit``
            Button(action: {
                userListViewModel.reset()
                userListViewModel.userItem = user
                isEdit.toggle()
            }, label: {
                Label("Edit",systemImage: "pencil")
            })
            .tint(.blue)
        }
    }
}

