//
//  CountryListViewModel.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 18/10/23.
//

import Foundation
import Combine
import SwiftUI

class CountryListViewModel: ObservableObject {
    
    @Published private(set) var countries: [Country]!
    @Published private(set) var state: LoadingState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    private var networkRequestsManager: CountryNetworkRequestsManager
    
    // Initialize CountryNetworkRequestsManager
    /// `Dependency Injection`
    init(_ networkRequestsManager: CountryNetworkRequestsManager) {
        self.networkRequestsManager = networkRequestsManager
    }
    
}

extension CountryListViewModel: CountriesListViewProtocol {
    
    // Get the Formatted Data from Country Entity / Model via Tuple
    func getFormattedData(for country: Country) -> (countryId: String,
                                                    countryFlagEmoji: String,
                                                    countryPhoneCode: String) {
        let countryId = country.name.common
        let countryFlagEmoji = country.flag
        let suffixes : String? = (country.idd.suffixes?.count ?? 0 == 1) ? country.idd.suffixes?.first : ""
        //country.idd.suffixes?.joined(separator: "")
        let countryPhoneCode = country.idd.root + (suffixes ?? "")
        
        return (countryId, countryFlagEmoji, countryPhoneCode)
    }
    
    
    // Get Countries List via Network Request Manager
    // CountriesListViewModel conforms CountriesListViewProtocol
    func getCountries() {
        state = .loading
        self.networkRequestsManager.fetchData()
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                    self?.state = .failed(error)
                    
                default:
                    print("finished with Result:\(result)")
                }
            }, receiveValue: { [weak self] countries in
                
                self?.countries = countries.sorted(by: { item1, item2 in
                    return item1.name.common < item2.name.common
                })
                self?.state = .success
                
            })
            .store(in: &cancellables)
    }
}

