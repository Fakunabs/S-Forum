//
//  User.swift
//  S-Forum
//
//  Created by Fakunabs on 08/11/2023.
//

import Foundation
import UIKit

struct LoginResponse: Codable {
    let message: String?
    let token: String?
    let user: User?
    
    private enum CodingKeys : String, CodingKey {
        case message, token
        case user = "data"
    }
}

struct UserResponse: Codable {
    let message: String?
    let token: String?
    let user: User?
    
    private enum CodingKeys : String, CodingKey {
        case message, token
        case user
    }
}

struct RegisterResponse: Codable {
    let message: String?
    
    private enum CodingKeys : String, CodingKey {
        case message
    }
}

struct ForgotPasswordResponse: Codable {
    let message: String?
    
    private enum CodingKeys : String, CodingKey {
        case message
    }
}

struct User: Codable {
    let id, email, password, passwordResetToken: String?
    let roleName: String?
    let deleted: Bool?
    let createdAt, updatedAt: String?
    let v: Int?
    let isActive, dayOfBirth, firstName: String?
    let gender: Bool?
    let lastName: String?
    let phone: Int?
    let profileImage: String?
}
