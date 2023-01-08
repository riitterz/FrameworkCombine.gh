//
//  Method.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation

enum Method {
    
    static let baseUrl = URL(string: "https://rickandmortyapi.com/api/")!
    static let characterPath = "character/"
    
    case page(Int)
    case character(Int)
    case location
    case episode
    
    var url: URL {
        switch self {
        case .page(let num):
            let urlString = Method.baseUrl.appendingPathComponent(Method.characterPath).absoluteString
            var urlComps = URLComponents(string: urlString)
            urlComps?.queryItems = [URLQueryItem(name: "page", value: "\(num)")]
            return urlComps?.url ?? Method.baseUrl
        case .character(let id):
            return Method.baseUrl.appendingPathComponent(Method.characterPath + String(id))
        default:
            fatalError("URl for this case is undefined.")
        }
    }
}
