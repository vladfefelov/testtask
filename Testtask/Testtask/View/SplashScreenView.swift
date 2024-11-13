//
//  SplashScreenView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Colors.primary
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 95.42, height: 65.09)
                    .opacity(isActive ? 1 : 0)
                    .animation(.easeIn(duration: 1.5), value: isActive)
                
                Text("TESTTASK")
                    .font(TextStyles.heading1)
                    .opacity(isActive ? 1 : 0)
                    .animation(.easeIn(duration: 1.5), value: isActive)
            }
        }
        .onAppear {
            withAnimation {
                isActive = true
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
