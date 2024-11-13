//
//  UserCardView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct UserCardView: View {
    let name: String
    let role: String
    let email: String
    let phone: String
    let profileImage: Image

    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(TextStyles.body2)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                    
                    Text(role)
                        .font(TextStyles.body3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    Text(email)
                        .font(TextStyles.body3)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(phone)
                        .font(TextStyles.body3)
                }
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardView(
            name: "Seraphina Anastasia Isolde Aurelia Celestina von Hohenzollern",
            role: "Backend developer",
            email: "maximus_wilderman_ronaldo_schuppe@example.com",
            phone: "+38 (098) 278 76 24",
            profileImage: Image(systemName: "person.crop.circle") 
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

