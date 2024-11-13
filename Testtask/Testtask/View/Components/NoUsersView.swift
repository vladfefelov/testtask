//
//  NoUsersView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct NoUsersView: View {
    var body: some View {
        VStack {
            Image("success-image")
                .resizable()
                .scaledToFit()
                .frame(width: 201, height: 200)
            
            Text("There are no users yet")
                .foregroundColor(Color.black)
                .font(TextStyles.heading1)
                .padding(.top, 16)
        }
    }
}
