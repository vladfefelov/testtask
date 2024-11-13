//
//  BottomBar.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: MainScreen.Tab
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person.3")
                    .font(Font.custom("SFPro", size: 14))
                    .fontWeight(.medium)
                Text("Users")
                    .font(TextStyles.body1)
            }
            .foregroundColor(selectedTab == .users ? Colors.secondary : .gray)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selectedTab = .users
            }
            
            HStack {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(Font.custom("SFPro", size: 14))
                    .fontWeight(.medium)
                Text("Sign up")
                    .font(TextStyles.body1)
            }
            .foregroundColor(selectedTab == .signup ? Colors.secondary : .gray)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selectedTab = .signup
            }
        }
        .padding()
        .background(Colors.lightGrayColor)
    }
}
