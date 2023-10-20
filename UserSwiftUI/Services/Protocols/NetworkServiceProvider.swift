//
//  NetworkService.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import Foundation
import Combine

protocol NetworkServiceProvider {
    // Associated Type (Entity, Model) Object
    associatedtype ResponseObj
    
    // Fetch Data from Server
    func fetchData() -> AnyPublisher<[ResponseObj], Error>
}
