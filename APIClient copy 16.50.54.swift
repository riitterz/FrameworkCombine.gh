//
//  APIClient.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation
import Combine

struct APIClient {

    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

    func page(num: Int) -> AnyPublisher<Page, Error> {
       return  URLSession.shared
            .dataTaskPublisher(for: Method.page(num).url)
            .handleEvents()
            .receive(on: queue)
            .map(\.data)
            .decode(type: Page.self, decoder: decoder)
            .mapError({ error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachableAddres(url: Method.page(num).url)
                default:
                    return Error.invalidResource
                }
            })
            .eraseToAnyPublisher()
    }
    
    func character(id: Int) -> AnyPublisher<Character, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.character(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Character.self, decoder: decoder)
            .mapError({ error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachableAddres(url: Method.character(id).url)
                default:
                    return Error.invalidResource
                }
            })
            .eraseToAnyPublisher()
    }

    func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, Error> {
        precondition(!ids.isEmpty)

        let initialPublisher = character(id: ids[0])
        let remainder = Array(ids.dropFirst())

        return remainder.reduce(initialPublisher) { (combined, id) in
            return combined
                .merge(with: character(id: id))
                .eraseToAnyPublisher()
        }
    }
}
