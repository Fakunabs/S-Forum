//
//  CreatePostResponse.swift
//  S-Forum
//
//  Created by Fakunabs on 15/11/2023.
//

import Foundation

// MARK: - NewestBlogResponse
struct CreatePostResponse: Codable {
    let title: String!
    let userID, content: String?
    let blogImage: [String]?
    let status: String?
    let reactionCount: Int?
    let id: String?
    let deleted: Bool?
    let reaction: [JSONAny]?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case title, content, blogImage, status, reactionCount
        case id = "_id"
        case deleted, reaction, createdAt, updatedAt
        case v = "__v"
    }
}
