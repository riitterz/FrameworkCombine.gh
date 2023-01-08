//
//  SectionHeaderView.swift
//  Rick&Morty
//
//  Created by Macbook on 06.01.2023.
//

import SwiftUI

struct SectionHeaderView: View {
    let header: String
    let lastUpdateTime: TimeInterval
    let currentDate: Date
    
    private var relativeTimeString: String {
        return RelativeDateTimeFormatter().localizedString(fromTimeInterval: lastUpdateTime)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
            Text("last update \(relativeTimeString)")
                .font(.subheadline)
        }
    }
}

