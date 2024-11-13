//
//  TopBar.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct TopBar: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Colors.primary)
                .foregroundColor(.black)
                .font(TextStyles.heading1)
        }
    }
}

