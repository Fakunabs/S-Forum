//
//  User.swift
//  S-Forum
//
//  Created by Fakunabs on 08/11/2023.
//

import Foundation
import UIKit


public enum Gender: CaseIterable, RawRepresentable {

    case male
    case female

    public init?(rawValue: Bool) {
        self = rawValue ? .male : .female
    }

    public var rawValue: Bool {
        switch self {
        case .male:
            return true
        case .female:
            return false
        }
    }
}

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
    let id, email, password: String?
    var firstName: String? // change
    let passwordResetToken, isActive, roleName: String?
    let deleted: Bool?
    let createdAt, updatedAt: String?
    let v: Int?
    var dayOfBirth: String? // change
    var gender: Bool? // change
    var lastName: String? // change
    var phone: Int? // change
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, email, password, passwordResetToken, isActive, roleName, deleted, createdAt, updatedAt
        case v = "__v"
        case dayOfBirth, gender, lastName, phone, profileImage
    }
    
    func getGender() -> Gender? {
        return Gender(rawValue: gender ?? true)
    }
}

