//
//  FilterSettingView.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import SwiftUI

struct FilterSettingView: View {
//    @State private var tags: [Tag] = []
    @EnvironmentObject var filter: Filter
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Tag.allCases) { tag in
                    Button {
                        self.changeTagStyle(tag)
                    } label: {
                        HStack {
                            if self.filter.tags.contains(tag) {
                                Image(systemName: "checkmark.circle.fill")
                            }
                            Text(tag.rawValue.capitalized)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Tags"))
            .navigationBarItems(
                trailing: Button("Done") {
                    
                }
            )
        }
    }
    
    func changeTagStyle(_ tag: Tag) {
        filter.tags.contains(tag)
        ? filter.tags.removeAll(where: { $0 == tag })
        : filter.tags.append(tag)
    }
}

struct FilterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSettingView()
    }
}
