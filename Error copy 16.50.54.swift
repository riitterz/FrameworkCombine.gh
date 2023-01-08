//
//  Error.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation

enum Error: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    case unreachableAddres(url: URL)
    case invalidResource
    
    var errorDescription: String? {
        switch self {
        case .unreachableAddres(let url):
            return "\(url.absoluteString) is unreachable"
        case .invalidResource:
            return "Response with mistake"
        }
    }
}
