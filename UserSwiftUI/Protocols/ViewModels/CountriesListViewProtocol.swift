//
//  CountriesListViewProtocol.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 14/10/23.
//

import Foundation
import Combine

protocol CountriesListViewProtocol {
    // Get Countries List via Network Request Manager
    // CountriesListViewModel conforms CountriesListViewProtocol
    func getCountries()
    
    // Get the Formatted Data from Country Entity / Model via Tuple
    func getFormattedData(for country: Country) -> (countryId: String,
                                                     countryFlagEmoji: String,
                                                     countryPhoneCode: String) 
}
