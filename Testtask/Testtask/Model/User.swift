//
//  User.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 11.11.2024.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Int
    let photo: URL
    
    private enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionId = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}

struct UserResponse: Codable {
    let success: Bool
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let page: Int
    let links: PaginationLinks
    let users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case success, count, page, users
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case links
    }
}

struct PaginationLinks: Codable {
    let nextURL: URL?
    let prevURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}
