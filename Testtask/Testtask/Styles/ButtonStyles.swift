//
//  Buttons.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let isEnabled: Bool

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(TextStyles.body1)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(isEnabled ? Colors.primary : Color.gray.opacity(0.5))
                .foregroundColor(.black)
                .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    let isPressed: Bool

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(TextStyles.body1)
                .foregroundColor(isPressed ? Colors.secondary.opacity(0.6) : Colors.secondary)
                .padding()
        }
        .background(isPressed ? Color.blue.opacity(0.2) : Color.clear)
        .cornerRadius(24)
    }
}


