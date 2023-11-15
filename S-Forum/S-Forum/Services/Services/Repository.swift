//
//  Repository.swift
//  S-Forum
//
//  Created by Fakunabs on 04/11/2023.
//

import Foundation
import Alamofire

class Repository {
    
    // Hàm đăng nhập
    static func login(email: String, password: String) async throws -> User? {
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        do {
            let loginResponse: LoginResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.login, parameters: body, method: .post, headers: [
                "Content-Type": "application/json"])
            AuthenticationManager.shared.cache(accessToken: loginResponse.token) // lưu token vào máy
            let result = try await getUserInfomation() // lưu thông tin user
            return result
        } catch {
            throw error
        }
    }
    
    static func getUserInfomation() async throws -> User? {
        do {
            let headers: HTTPHeaders?
            if let token = AuthenticationManager.shared.accessToken {
                headers = [
                    "Authorization": "Bearer \(token)"
                ]
            } else {
                headers = nil
            }
            
            let user: User = try await APIService.shareInitial.requestAPIData(from: APIURLs.userInfomation, parameters: nil, method: .get, headers: headers)
            AuthenticationManager.shared.cache(user: user)
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
            let data : ForgotPasswordResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.forgotPassword, parameters: body, method: .post, headers: [
                "Content-Type": "application/json"])
            return data
        } catch {
            throw error
        }
    }
    
    static func getNewestBlog() async throws -> [NewestBlog] {
        do {
            let data: NewestBlogResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.newestBlog, parameters: nil, method: .get, headers: nil)
            let listNewestblogs : [NewestBlog] = data.docs
            return listNewestblogs
        } catch {
            print(String(describing: error))
        }
        return []
    }
    
    static func getPopularBlog() async throws -> [PopularBlog] {
        do {
            let data: PopularBlogResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.popularBlog, parameters: nil, method: .get, headers: nil)
            let listPopularBlogs: [PopularBlog] = data.docs
            return listPopularBlogs
        } catch {
            print(String(describing: error))
        }
        return []
    }
    
    static func getUserBlogs() async throws -> [UserBlog] {
        do {
            let headers: HTTPHeaders?
            if let token = AuthenticationManager.shared.accessToken {
                headers = [
                    "Authorization": "Bearer \(token)"
                ]
            } else {
                headers = nil
            }
            let data: UserBlogResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.userBlog, parameters: nil, method: .get, headers: headers)
            let listUserBlogs: [UserBlog] = data.docs
            return listUserBlogs
        } catch {
            print(String(describing: error))
        }
        return []
    }
    
    
    static func updateInformation(firstName: String, lastName: String, gender: Bool, dayOfBirth: String, phone: Int) async throws -> String {
        let parameters: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "gender": gender,
            "dayOfBirth": dayOfBirth,
            "phone": phone
        ]
        do {
            let headers: HTTPHeaders?
            if let token = AuthenticationManager.shared.accessToken {
                headers = [
                    "Authorization": "Bearer \(token)",
                    "Content-Type": "application/json"
                ]
            } else {
                headers = nil
            }
            let data : UpdateInformationResponse = try await APIService.shareInitial.requestAPIData(from: APIURLs.updateUser, parameters: parameters, method: .put, headers: headers)
            return data.message
        } catch {
            throw error
        }
    }
}


