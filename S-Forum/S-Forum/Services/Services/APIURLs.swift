//
//  APIURLs.swift
//  S-Forum
//
//  Created by Fakunabs on 04/11/2023.
//

import Foundation



struct APIURLs {
    
    static let baseURL = "https://capstone-be-deploy-production.up.railway.app/api"
    static let login = baseURL + "/auth/login"
    static let regiter = baseURL + "/auth/register"
    static let userInfomation = baseURL + "/users/me"
    static let forgotPassword = baseURL + "/auth/forgot-password"
    static let newestBlog = baseURL + "/blogs/newest"
    static let popularBlog = baseURL + "/blogs/popular"
    static let updateUser = baseURL + "/users/" + (AuthenticationManager.shared.user?.id ?? "Error")
}
