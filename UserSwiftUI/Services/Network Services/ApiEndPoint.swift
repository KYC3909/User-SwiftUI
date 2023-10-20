//
//  ApiEndPoint.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import Foundation

// MARK: - Api Endpoint
enum ApiEndpoint {
    case getCountries

    // Generate End Point String
    // based on Case `Get Countries`
    var endpointString: String {
        switch self {
        case .getCountries:
            return "/\(Version.v31.rawValue)/all"
        }
    }
}

extension ApiEndpoint {
    
    // HTTP Method
    var method: String {
        switch self {
        case .getCountries:
            return HTTPMethod.GET.rawValue
        }
    }

    // Field Items
    var fieldItems: [String] {
        switch self {
        case .getCountries:
            return [FieldType.name.rawValue,
                    FieldType.region.rawValue,
                    FieldType.flag.rawValue,
                    FieldType.countryCode.rawValue,
            ]
        }
    }

    // URL Components Query Items
    var queryItems: [URLQueryItem] {
        switch self {
        case .getCountries:
            return []
        }
    }
    
    
    // HTTP Body
    var httpBody: Data? {
        switch self {
        case .getCountries:
            return nil
        }
    }
}


