//
//  Repository.swift
//  S-Forum
//
//  Created by Fakunabs on 04/11/2023.
//

import Foundation
import Alamofire

//enum CusErr: Error {
//    case statusCode(Int)
//}

class Repository {
    static func login(email: String, password: String) async throws -> User? {
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        do {
            let data: LoginResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.login, parameters: body, method: .post, headers: [
                "Content-Type": "application/json"])
            let user = data.user
            AuthenticationManager.shared.cache(user: user)
            AuthenticationManager.shared.cache(accessToken: data.token)
            return user
        } catch {
            throw error
        }
    }
}


