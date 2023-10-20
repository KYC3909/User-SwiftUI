//
//  NetworkRequestsProvider.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import Foundation

final class NetworkRequestsProvider {
    private let baseURL: URL

    // Initialize with Base URL
    /// `Dependency Injection`
    init(baseURLString: String = ServerEndPoint.baseURL) {
        let url = URL(string: baseURLString)!
        self.baseURL = url
    }

    // Generate URL Request
    func createRequestFor(for endpoint: ApiEndpoint) -> URLRequest {
        var urlString = baseURL.absoluteString + endpoint.endpointString

        let fieldItems = endpoint.fieldItems.joined(separator: ",")
        urlString += fieldItems.isEmpty ? "" :  ("?fields=" + fieldItems)

        
        let urlComponent = URLComponents(string: urlString)

        let requestURL = urlComponent!.url

        // Cache policy `Use Cache Data` since the data won't be changed frequently
        /// ``.returnCacheDataElseLoad``
        // First Time it will load data from Server
        var urlRequest = URLRequest(url: requestURL!,
                                    cachePolicy: .returnCacheDataElseLoad)
        urlRequest.timeoutInterval = 30

        urlRequest.httpMethod = endpoint.method
        urlRequest.httpBody = endpoint.httpBody
        return urlRequest
    }
}
