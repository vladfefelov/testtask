//
//  UserService.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import SwiftUI
import UIKit

struct RegisterResponse: Codable {
    let success: Bool
    let message: String
}

struct TokenResponse: Codable {
    let success: Bool
    let token: String
}

class UserService {
    private let baseURL = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1")!
    
    func fetchUsers(page: Int, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent("/users"), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "count", value: "6")
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            if let data = data {
                do {
                    let usersResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(usersResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func fetchToken(completion: @escaping (Result<String, Error>) -> Void) {
        print("Начался запрос токена")
        let url = baseURL.appendingPathComponent("/token")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка при получении токена:", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("Нет данных от запроса токена")
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No data"])
                completion(.failure(error))
                return
            }
            
            do {
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                if tokenResponse.success {
                    print("Токен получен успешно:", tokenResponse.token)
                    completion(.success(tokenResponse.token))
                } else {
                    print("Не удалось получить токен")
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to get token"])
                    completion(.failure(error))
                }
            } catch {
                print("Ошибка декодирования токена:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    func registerUser(name: String, email: String, phone: String, positionId: Int, photo: UIImage, completion: @escaping (Result<RegisterResponse, CustomError>) -> Void) {
        print("Вызов registerUser начался")
        fetchToken { result in
            switch result {
            case .success(let token):
                print("Токен успешно получен:", token)
                self.performUserRegistration(name: name, email: email, phone: phone, positionId: positionId, photo: photo, token: token, completion: completion)
            case .failure(let error):
                print("Ошибка при получении токена:", error.localizedDescription)
                completion(.failure(error as! UserService.CustomError))
            }
        }
    }
    
    struct CustomError: Error {
        let message: String
    }
    
    private func performUserRegistration(name: String, email: String, phone: String, positionId: Int, photo: UIImage, token: String, completion: @escaping (Result<RegisterResponse, CustomError>) -> Void) {
        print("Начался запрос регистрации")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let url = baseURL.appendingPathComponent("/users")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Token")
        
        var body = Data()
        let fields: [(String, String)] = [
            ("name", name),
            ("email", email),
            ("phone", phone),
            ("position_id", "\(positionId)")
        ]
        
        for (key, value) in fields {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        if let imageData = photo.jpegData(compressionQuality: 0.7) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса:", error.localizedDescription)
                completion(.failure(CustomError(message: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                let errorMessage = "Ошибка: нет данных в ответе"
                print(errorMessage)
                completion(.failure(CustomError(message: errorMessage)))
                return
            }
            
            // Вывод ответа сервера в текстовом формате для отладки
            if let responseString = String(data: data, encoding: .utf8) {
                print("Ответ сервера: \(responseString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RegisterResponse.self, from: data)
                if response.success {
                    print("Регистрация успешна: \(response.message)")
                    completion(.success(response))
                } else {
                    let errorMessage = response.message
                    print("Ошибка регистрации:", errorMessage)
                    completion(.failure(CustomError(message: errorMessage)))
                }
            } catch {
                print("Ошибка декодирования ответа:", error.localizedDescription)
                let parseError = CustomError(message: "Не удалось декодировать ответ сервера")
                completion(.failure(parseError))
            }
        }.resume()
    }
    
    private func getNewToken(completion: @escaping (Result<String, Error>) -> Void) {
        let tokenUrl = baseURL.appendingPathComponent("/token")
        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let newToken = json["token"] as? String {
                        completion(.success(newToken))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve token"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

