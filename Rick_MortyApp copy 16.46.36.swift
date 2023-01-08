//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import SwiftUI
import Combine

@main
struct Rick_MortyApp: App {
    let viewModel = CharactersViewModel()
    let filter = Filter()
    var cancellable = Set<AnyCancellable>()
    
    var body: some Scene {
        WindowGroup {   
            CharactersView(viewModel: viewModel)
                .environmentObject(filter)
            
        }
    }
}
