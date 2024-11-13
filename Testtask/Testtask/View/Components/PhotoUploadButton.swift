//
//  PhotoUploadButton.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI
import UIKit
struct PhotoUploadButton: View {
    @Binding var isPhotoUploaded: Bool
    @Binding var selectedImage: UIImage?
    @Binding var photoError: Bool
    
    @State private var showAlert = false
    @State private var isImagePickerPresented = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        HStack {
            Text("Upload your photo")
                .font(TextStyles.body2)
                .foregroundColor(photoError ? .red : .gray)
                .padding()
            
            Spacer()
            
            SecondaryButton(title: "Upload", action: {
                showAlert = true
            }, isPressed: false)
            .onChange(of: isPhotoUploaded) { _ in
                if photoError {
                    photoError = !isPhotoUploaded
                }
            }
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(
                    title: Text("Choose how you want to add a photo"),
                    buttons: [
                        .default(Text("Camera"), action: {
                            imagePickerSourceType = .camera
                            isImagePickerPresented = true
                        }),
                        .default(Text("Gallery"), action: {
                            imagePickerSourceType = .photoLibrary
                            isImagePickerPresented = true
                        }),
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $isImagePickerPresented) {
                if imagePickerSourceType == .camera {
                    ImagePicker(selectedImage: $selectedImage, isPhotoUploaded: $isPhotoUploaded, sourceType: .camera)
                } else {
                    ImagePicker(selectedImage: $selectedImage, isPhotoUploaded: $isPhotoUploaded, sourceType: .photoLibrary)
                }
            }
        }
        .background(Colors.background)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

struct PhotoUploadButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadButton(isPhotoUploaded: .constant(false), selectedImage: .constant(nil), photoError: .constant(false))
    }
}
