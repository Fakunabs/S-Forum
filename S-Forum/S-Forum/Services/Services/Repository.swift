//
//  Repository.swift
//  S-Forum
//
//  Created by Fakunabs on 04/11/2023.
//

import Foundation
import Alamofire

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
    
    static func regiter(email: String, password: String) async throws -> RegisterResponse? {
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        do {
            let data : RegisterResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.regiter, parameters: body, method: .post, headers: [
                "Content-Type": "application/json"])
            return data
        } catch {
            throw error
        }
    }
    
    static func forgotPassword(email: String) async throws -> ForgotPasswordResponse? {
        let body: [String: String] = [
            "email": email,
        ]
        do {
            let data : ForgotPasswordResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.regiter, parameters: body, method: .post, headers: [
                "Content-Type": "application/json"])
            return data
        } catch {
            throw error
        }
    }
    
    
}


