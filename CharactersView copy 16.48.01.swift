//
//  CharactersView.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    
    @State  var currentDate = Date()
    @State private var filterIsPresented = false
    
    @ObservedObject var viewModel: CharactersViewModel
    @EnvironmentObject var filter: Filter
    
    var filterSettingsIsPresented = false
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    private var timer = Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    var body: some View {
        let filter = "All characters"
        
        return NavigationView {
            List {
                Section(header: SectionHeaderView(header: filter, lastUpdateTime: viewModel.lastUpdateTime, currentDate: self.currentDate)) {
                    ForEach(self.viewModel.characters) { charachter in
                        CharacterView(charachter: charachter)
                    }
                    //Timer
                    .onReceive(timer) {
                        self.currentDate = $0
                    }
                }
                .padding(2)
            }

            //show settings menu
            .sheet(isPresented: $filterIsPresented) {
                FilterSettingView()
                    .environmentObject(self.filter)
            }
            
            //show errors
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Network errpr"), message: Text(error.localizedDescription), dismissButton: .cancel())
            }
            .navigationBarTitle(Text("Characters"))
            .navigationBarItems(trailing: Button("Filter") {
                filterIsPresented.toggle()
            })
        }.onAppear() {
            viewModel.fatchCharacters()
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel())
    }
}
