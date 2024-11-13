//
//  UserRowView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                AsyncImage(url: user.photo) { image in
                    image.resizable()
                         .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(TextStyles.body2)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                    
                    Text(user.position)
                        .font(TextStyles.body3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    Text(user.email)
                        .font(TextStyles.body3)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(user.phone)
                        .font(TextStyles.body3)
                }
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
}

