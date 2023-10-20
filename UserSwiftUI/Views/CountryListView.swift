//
//  CountryListView.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 18/10/23.
//

import SwiftUI

struct CountryListView: View {
    @Binding var countryId: String
    @Binding var countryFlagEmoji: String
    @Binding var countryPhoneCode: String
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var countryListViewModel = CountryListViewModel(CountryNetworkRequestsManager(NetworkRequestsProvider()))
    
    var body: some View {
        VStack {
            
            // Check for Loading State
            switch countryListViewModel.state {
                
                // Show Error message when Failed to receive response
            case .failed(let error):
                Text(error.localizedDescription)
                
                
                // Show Country list once succes respose received
            case .success:
                if countryListViewModel.countries.count == 0 {
                    Text("Please close the Picker and Try again.")
                }else {
                    List(countryListViewModel.countries, id: \.id) { country in
                        Button {
                            let (name,
                                 flag,
                                 phoneCode) = countryListViewModel.getFormattedData(for: country)
                            
                            countryId = name
                            countryFlagEmoji = flag
                            countryPhoneCode = phoneCode
                            dismiss()
                        } label: {
                            
                            // Show Flag Emoji followed bt Country Name
                            // E.g.
                            //  🇺🇸 United States
                            HStack{
                                Text(country.flag)
                                    .padding(EdgeInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 4)))
                                Text(country.name.common)
                                    .padding(EdgeInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 4)))
                                    .foregroundColor(.blue)
                            }
                            
                        }
                    }
                    
                }
                
                // Show Progress View for loading
            case .loading:
                ProgressView()
            }
            
        }
        .onAppear {
            Task {
                countryListViewModel.getCountries()
            }
        }
    }
}
