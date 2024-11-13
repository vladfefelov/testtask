//
//  TextFieldStyles.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct TextFieldStyles: View {
    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var isError: Bool
    var type: TextFieldTypes
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .leading) {
                TextField("", text: $text, onEditingChanged: { focused in
                    withAnimation {
                        isFocused = focused
                    }
                })
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: 1)
                )
                .textFieldStyle(PlainTextFieldStyle())
                .font(TextStyles.body2)
                .keyboardType(keyboardType) // Устанавливаем тип клавиатуры
                
                Text(placeholder)
                    .foregroundColor(isError ? .red : .gray)
                    .offset(y: text.isEmpty ? 0 : -30) // Положение метки
                    .scaleEffect(text.isEmpty ? 1 : 0.6, anchor: .leading) // Размер метки
                    .animation(.easeInOut(duration: 0.2), value: text.isEmpty) // Анимация
                    .font(TextStyles.body2)
                    .padding()
            }
            .padding(.top, 20)
            
            if isError {
                Text(errorText)
                    .font(TextStyles.body3)
                    .foregroundColor(.red)
            } else if type == .phone {
                Text("+38 (XXX) XXX - XX - XX")
                    .font(TextStyles.body3)
                    .foregroundColor(.gray)
            }
        }
    }
    
    // Определение типа клавиатуры
    private var keyboardType: UIKeyboardType {
        switch type {
        case .name:
            return .default
        case .email:
            return .emailAddress
        case .phone:
            return .phonePad
        }
    }
    
    private var placeholder: String {
        switch type {
        case .name:
            return "Your name"
        case .email:
            return "Email"
        case .phone:
            return "Phone"
        }
    }
    
    private var errorText: String {
        switch type {
        case .name:
            return "Name should be 2-60 characters"
        case .email:
            return "Invalid email format"
        case .phone:
            return "Phone number must start with +380 and be 13 characters"
        }
    }
    
    private var borderColor: Color {
        if isError {
            return .red
        } else if isFocused {
            return Colors.secondary
        } else {
            return Color.gray.opacity(0.5)
        }
    }
}

enum TextFieldTypes {
    case name
    case email
    case phone
}

struct TextFieldStyles_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldStyles(
            text: .constant("1"),
            isFocused: .constant(false),
            isError: .constant(true),
            type: .phone // Указываем тип поля для предпросмотра
        )
    }
}
