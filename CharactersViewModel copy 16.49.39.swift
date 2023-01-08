//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    
    @Published private var allCharacters: [Character] = []
    @Published var error: Error? = nil
    @Published var lastUpdateTime: TimeInterval = Date().timeIntervalSince1970
    
    private var apiClient = APIClient()
    private var currentPage = 1
    
    var cancellable: Set<AnyCancellable> = []
    
    var filterTags: [Tag] = []
    var characters: [Character] {
        guard !filterTags.isEmpty else {
            return allCharacters
        }
        
        return allCharacters
            .filter { (character) -> Bool in
                return filterTags.reduce(false) { (isMatch, tag) -> Bool in
                    self.chackMatching(character: character, for: tag)
                }
            }
    }
    
    func fatchCharacters() {
        apiClient
            .page(num: currentPage + 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] page in
                self?.error = nil
                self?.allCharacters.append(contentsOf: page.results)
                self?.currentPage += 1
                self?.lastUpdateTime = Date().timeIntervalSince1970
            }).store(in: &cancellable)
    }
    
    private func chackMatching(character: Character, for tag: Tag) -> Bool {
        switch tag {
            case .alive, .dead:
            return character.status.lowercased() == tag.rawValue.lowercased()
        case .female, .male, .genderless:
            return character.gender.lowercased() == tag.rawValue.lowercased()
        }
    }
}
