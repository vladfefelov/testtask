//
//  PositionService.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import Foundation

class PositionService {
    private let baseURL = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1")!
    
    func fetchPositions(completion: @escaping (Result<[Position], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/positions")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let positionResponse = try JSONDecoder().decode(PositionResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(positionResponse.positions))
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
}

