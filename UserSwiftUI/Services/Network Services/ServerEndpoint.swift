//
//  APIEndpoint.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 16/10/23.
//

import Foundation

// MARK: - Server Endpoint
struct ServerEndPoint {
//    static let baseURL = "https://restcountries.com/v3.1/all?fields=name,region,flag,idd"
    static let baseURL = "https://restcountries.com"
}


// MARK: - Version
enum Version: String {
    case v31 = "v3.1"
}

// MARK: - HTTP Method
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: - Field Type
enum FieldType: String {
    case name = "name"
    case region = "region"
    case flag = "flag"
    case currency = "currency"
    case language = "lang"
    case capitalCity = "capital"
    case countryCode = "idd"
}

extension FieldType: CaseIterable{}
