//
//  MainScreen.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI
import UIKit
import Network

struct MainScreen: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var selectedTab: Tab = .users 
    @StateObject private var networkMonitor = NetworkMonitor()
    
    enum Tab {
        case users
        case signup
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if networkMonitor.isConnected {
                TopBar(title: selectedTab == .users ? "Working with GET request" : "Working with POST request")
                
                if selectedTab == .users {
                    // Экран списка пользователей
                    if viewModel.users.isEmpty {
                        Spacer()
                        NoUsersView()
                        Spacer()
                    } else {
                        List {
                            ForEach(viewModel.users) { user in
                                UserRowView(user: user)
                                    .onAppear {
                                        if viewModel.users.last == user {
                                            viewModel.loadUsers()
                                        }
                                    }
                            }
                            HStack {
                                Spacer()
                                ProgressView().id(UUID())
                                    .padding()
                                    .controlSize(.large)
                                Spacer()
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                } else if selectedTab == .signup {
                    SignUpView()
                }
                
                BottomBar(selectedTab: $selectedTab)
            }
        }
        .background(Colors.background)
        .onAppear {
            viewModel.loadUsers()
        }
        .fullScreenCover(isPresented: .constant(!networkMonitor.isConnected)) {
            NoInternetView(networkMonitor: networkMonitor)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
