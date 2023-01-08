//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    var charachter: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(charachter.name)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button {
                    
                } label: {
                    Text("More")
                }.font(.callout)
            }
            .font(.title)
            KFImage(URL(string: charachter.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Gender: " + charachter.gender)
            Text("Status: " + charachter.status)
            if charachter.type.isEmpty == false {
                Text("Type: " + charachter.type)
            }
        }
        .padding()
    }
}

