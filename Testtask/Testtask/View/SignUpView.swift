//
//  SignUpView.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var nameTextFieldisFocused: Bool = false
    @State private var nameTextFieldText: String = ""
    @State private var nameTextFieldisError: Bool = false
    
    @State private var emailTextFieldisFocused: Bool = false
    @State private var emailTextFieldText: String = ""
    @State private var emailTextFieldisError: Bool = false
    
    @State private var phoneTextFieldisFocused: Bool = false
    @State private var phoneTextFieldText: String = ""
    @State private var phoneTextFieldisError: Bool = false
    
    @State private var photoError: Bool = false
    @State private var isActionSheetPresented = false
    
    private let positionService = PositionService()
    @State private var positions: [Position] = []
    @State private var selectedPositionId: Int = 1
    
    @State private var isPhotoUploaded = false
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    @State private var showSuccessView = false
    @State private var errorMessage: String = ""
    @State private var navigateToErrorView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    TextFieldStyles(text: $nameTextFieldText, isFocused: $nameTextFieldisFocused, isError: $nameTextFieldisError, type: .name)
                        .onChange(of: nameTextFieldText) { newValue in
                            nameTextFieldisError = !viewModel.isNameValid(newValue)
                        }
                    
                    TextFieldStyles(text: $emailTextFieldText, isFocused: $emailTextFieldisFocused, isError: $emailTextFieldisError, type: .email)
                        .onChange(of: emailTextFieldText) { newValue in
                            emailTextFieldisError = !viewModel.isEmailValid(newValue)
                        }
                    
                    TextFieldStyles(text: $phoneTextFieldText, isFocused: $phoneTextFieldisFocused, isError: $phoneTextFieldisError, type: .phone)
                        .onChange(of: phoneTextFieldText) { newValue in
                            phoneTextFieldisError = !viewModel.isPhoneValid(newValue)
                        }
                    
                    Text("Select your position")
                        .font(TextStyles.body2)
                        .padding(.top)
                    
                    if viewModel.positions.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(viewModel.positions) { position in
                            PositionRow(position: position, selectedPositionId: $viewModel.selectedPositionId)
                        }
                    }
                    
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                            PhotoUploadButton(isPhotoUploaded: $isPhotoUploaded, selectedImage: $selectedImage, photoError: $photoError)
                        }
                        .background(Colors.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        
                        if photoError {
                            Text("Photo is required and should be a JPEG under 5 MB")
                                .font(TextStyles.body3)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 20)
                    
                    HStack {
                        Spacer()
                        PrimaryButton(title: "Sign up", action: {
                            validateForm()
                            if isFormValid() {
                                let userService = UserService()
                                userService.registerUser(name: nameTextFieldText, email: emailTextFieldText, phone: phoneTextFieldText, positionId: selectedPositionId, photo: selectedImage ?? UIImage()) { result in
                                    switch result {
                                    case .success:
                                        showSuccessView = true
                                    case .failure(let error):
                                        errorMessage = error.message
                                        navigateToErrorView = true
                                    }
                                }
                            }
                        }, isEnabled: isFormValid())
                        Spacer()
                    }
                    
                    NavigationLink(
                        destination: RegistrationFailedView(errorMessage: errorMessage),
                        isActive: $navigateToErrorView
                    ) {
                        EmptyView()
                    }
                    
                }
                .padding()
                .onAppear {
                    viewModel.loadPositions()
                }
                .sheet(isPresented: $showSuccessView) {
                    RegistrationSuccessView()
                }
            }
        }
    }
    
    private func validateForm() {
        nameTextFieldisError = !viewModel.isNameValid(nameTextFieldText)
        emailTextFieldisError = !viewModel.isEmailValid(emailTextFieldText)
        phoneTextFieldisError = !viewModel.isPhoneValid(phoneTextFieldText)
        photoError = !isPhotoValid()
    }
    
    private func isFormValid() -> Bool {
        return viewModel.isNameValid(nameTextFieldText) &&
        viewModel.isEmailValid(emailTextFieldText) &&
        viewModel.isPhoneValid(phoneTextFieldText) &&
        selectedImage != nil && !photoError
    }
    
    
    private func isPhotoValid() -> Bool {
        guard let selectedImage = selectedImage else { return false }
        guard let imageData = selectedImage.jpegData(compressionQuality: 1.0) else { return false }
        return imageData.count <= 5 * 1024 * 1024
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
