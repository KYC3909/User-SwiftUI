//
//  UserCreateView.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import SwiftUI

struct UserCreateView: View {
    @EnvironmentObject var userListVM:UserListViewModel
    @Binding var addView:Bool
    @State var editing:Bool
    @State private var showingSheet = false
    
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView{
            Form{
                
                // Name
                HStack{
                    TextField("Name", text: $userListVM.name)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    if userListVM.textValidator.passedValidation != .notDetermined {
                        Spacer()
                        Image(systemName: userListVM.textValidator.passedValidation == .passed ? "checkmark.circle" :  "exclamationmark.circle")
                            .foregroundColor(userListVM.textValidator.passedValidation == .passed ? Color.green :  Color.red)
                    }
                }
                
                
                // Email
                HStack {
                    TextField("Email", text: $userListVM.email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    if userListVM.emailValidator.passedValidation != .notDetermined {
                        Spacer()
                        Image(systemName: userListVM.emailValidator.passedValidation == .passed ? "checkmark.circle" :  "exclamationmark.circle")
                            .foregroundColor(userListVM.emailValidator.passedValidation == .passed ? Color.green :  Color.red)
                    }
                }
                
                // Country Selector
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Text(userListVM.country.isEmpty ? "Select Country" : userListVM.country)
                }
                .sheet(isPresented: $showingSheet) {
                    CountryListView(countryId: $userListVM.country ,
                                    countryFlagEmoji: $userListVM.flagEmoji ,
                                    countryPhoneCode: $userListVM.countryCode
                    )
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                }
                
                
                // Country Code + Phone
                HStack{
                    if !userListVM.countryCode.isEmpty {
                        Text($userListVM.countryCode.wrappedValue)
                    }
                    TextField("Phone", text: $userListVM.phone)
                        .keyboardType(.numberPad)
                        .disabled(userListVM.country.isEmpty)
                    if userListVM.phoneValidator.passedValidation != .notDetermined {
                        Spacer()
                        Image(systemName: userListVM.phoneValidator.passedValidation == .passed ? "checkmark.circle" :  "exclamationmark.circle")
                            .foregroundColor(userListVM.phoneValidator.passedValidation == .passed ? Color.green :  Color.red)
                    }
                }
                
                
                // Add / Edit User Button
                Button(action: {
                    // Update Validators
                    userListVM.updateValidators()
                    
                    // Validate Name
                    if userListVM.textValidator.passedValidation != .passed{
                        errorMessage = userListVM.textValidator.getErrorMessage()
                        showingAlert.toggle()
                        return
                    }
                    
                    // Validate Email
                    if userListVM.emailValidator.passedValidation != .passed{
                        errorMessage = userListVM.emailValidator.getErrorMessage()
                        showingAlert.toggle()
                        return
                    }
                    
                    // Validate Country
                    if userListVM.country.isEmpty {
                        errorMessage = "Please select country"
                        showingAlert.toggle()
                        return
                    }
                    
                    // Validate Phone number
                    if userListVM.phoneValidator.passedValidation != .passed{
                        errorMessage = userListVM.phoneValidator.getErrorMessage()
                        showingAlert.toggle()
                        return
                    }
                    
                    // Save User to Local Data Store
                    userListVM.createUser()
                    
                    // Hide User Create View
                    addView.toggle()
                }, label: {
                    Text(!editing ? "Add User" : "Edit User")
                        .frame(minWidth: 0,maxWidth: .infinity)
                    
                })
                
                //  Show Alert when Validation Failed
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Validation failed"),
                        message: Text(errorMessage),
                        dismissButton: .cancel(
                            Text("Ok"),
                            action: {
                                errorMessage = ""
                            }
                        )
                    )
                }
                .tint(.blue)
                .fontDesign(.rounded)
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
            }
            .navigationTitle(!editing ? "Add User" : "Edit User")
        }
        .presentationDragIndicator(.visible)
    }
}
