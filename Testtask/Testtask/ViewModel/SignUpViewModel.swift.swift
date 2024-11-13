//
//  SignUpViewModel.swift.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 12.11.2024.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var positions: [Position] = []
    @Published var selectedPositionId: Int = 1 
    
    private let positionService = PositionService()
    
    func loadPositions() {
        positionService.fetchPositions { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let positions):
                    self.positions = positions
                case .failure(let error):
                    print("Failed to load positions:", error)
                }
            }
        }
    }
    
    func isNameValid(_ name: String) -> Bool {
        return name.count >= 2 && name.count <= 60
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPhoneValid(_ phone: String) -> Bool {
        return phone.starts(with: "+380") && phone.count == 13
    }
}
