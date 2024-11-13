//
//  ContentView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSplashScreen = true // Состояние для показа сплэш-экрана

    var body: some View {
        ZStack {
            MainScreen() // Основной экран приложения
            
            // Сплэш-экран поверх MainScreen
            if isShowingSplashScreen {
                SplashScreenView()
                    .transition(.opacity) // Плавное исчезновение
                    .onAppear {
                        // Убираем сплэш-экран через 2 секунды
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowingSplashScreen = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}


