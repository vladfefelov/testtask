//
//  RegistrationFailedView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct RegistrationFailedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let errorMessage: String
    
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
            
            Image("failed")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text(errorMessage)
                .font(TextStyles.heading1)
                .foregroundColor(.black)
            
            PrimaryButton(title: "Try again", action: {
                presentationMode.wrappedValue.dismiss()
            }, isEnabled: true)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct RegistrationFailedView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFailedView(errorMessage: "Error")
    }
}


