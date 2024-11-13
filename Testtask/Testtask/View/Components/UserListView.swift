//
//  UserListView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.users) { user in
                        UserCardView(
                            name: user.name,
                            role: user.position,
                            email: user.email,
                            phone: user.phone,
                            profileImage: Image(systemName: "person.crop.circle")
                        )
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
                .listStyle(PlainListStyle())
            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.loadUsers()
        }
    }
}
