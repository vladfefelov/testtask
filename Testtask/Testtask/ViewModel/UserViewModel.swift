//
//  UserViewModel.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var page = 1
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var userService = UserService()
    
    func loadUsers() {
        guard !isLoading else { return }
        isLoading = true
        
        userService.fetchUsers(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let userResponse):
                self.users.append(contentsOf: userResponse.users)
                self.users.sort { $0.registrationTimestamp > $1.registrationTimestamp }
                self.page += 1
            case .failure(let error):
                self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                print("Error loading users:", error)
            }
        }
    }
}


