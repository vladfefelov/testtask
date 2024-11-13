//
//  Position.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import Foundation

struct Position: Identifiable, Codable {
    let id: Int
    let name: String
}

struct PositionResponse: Codable {
    let success: Bool
    let positions: [Position]
}

