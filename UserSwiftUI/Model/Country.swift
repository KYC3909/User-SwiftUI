//
//  Country.swift
//  UsersForm
//
//  Created by Krunal Chauhan on 14/10/23.
//

import Foundation

struct Country : Decodable {
    var id = UUID()
    let name : Name
    let idd : Idd
    let region : String
    let flag : String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case idd = "idd"
        case region = "region"
        case flag = "flag"
    }
}

struct Name : Decodable {
    let common : String
}

struct Idd : Decodable {
    let root : String
    let suffixes : [String]?
}





extension Country: Identifiable, Equatable, Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(name.common)
    }
    
    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name.common == rhs.name.common
    }
}
extension Name: Equatable {}
extension Idd: Equatable {}
