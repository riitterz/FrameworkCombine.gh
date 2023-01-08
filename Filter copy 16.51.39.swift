//
//  Filter.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation

enum Tag: String, CaseIterable, Identifiable {
    case alive
    case dead
    case male
    case female
    case genderless
    
    var id: String {
        return self.rawValue
    }
}

final class Filter: ObservableObject {
    @Published var tags: [Tag] = []
    
    init() {}
}
