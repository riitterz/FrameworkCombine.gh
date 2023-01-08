//
//  Page.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation

public struct Page: Codable {
    
    public var info: PageInfo
    public var results: [Character]
    
    public init(info: PageInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}
