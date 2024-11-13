//
//  NoInternetView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 13.11.2024.
//

import SwiftUI

struct NoInternetView: View {
    @ObservedObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image("noInternet")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("There is no internet connection")
                .font(TextStyles.heading1)
                .foregroundColor(.black)
            
            PrimaryButton(title: "Try again", action: {
                networkMonitor.checkConnectionOnce() 
            }, isEnabled: true)
            
            Spacer()
        }
        .padding()
    }
}
