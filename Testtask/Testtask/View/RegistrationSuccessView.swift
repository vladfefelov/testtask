//
//  RegistrationSuccessView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct RegistrationSuccessView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Spacer()
            
            Image("success")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("User successfully registered")
                .font(TextStyles.heading1)
                .foregroundColor(.black)
            
            PrimaryButton(title: "Got it", action: {
                presentationMode.wrappedValue.dismiss()
            }, isEnabled: true)
            
            Spacer()
        }
        .padding()
    }
}

struct RegistrationSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSuccessView()
    }
}

