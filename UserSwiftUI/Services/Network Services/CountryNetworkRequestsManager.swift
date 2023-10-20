//
//  CountryNetworkRequestsManager.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 19/10/23.
//

import Foundation
import Combine

final class CountryNetworkRequestsManager: NetworkServiceProvider {
    /// Entity `Country`
    typealias ResponseObj = Country
    
    /// Private `Network Requests Provider`
    private var networkRequestsProvider: NetworkRequestsProvider
    
    /// `Dependency Injection`
    init(_ networkRequestsProvider: NetworkRequestsProvider) {
        self.networkRequestsProvider = networkRequestsProvider
    }
    
    // Fetch Data from Server
    func fetchData() -> AnyPublisher<[Country], Error> {
        
        // Generate Request to Get Countries List
        let urlRequest = networkRequestsProvider.createRequestFor(for: .getCountries)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Country].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
