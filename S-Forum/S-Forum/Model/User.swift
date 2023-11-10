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
    let _id : String
    var firstName : String
    let email: String
    var phone: String
    var profileImage: String?
}
