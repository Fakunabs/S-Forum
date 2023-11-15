//
//  UserBlog.swift
//  S-Forum
//
//  Created by Fakunabs on 14/11/2023.
//

import Foundation

// MARK: - PopularBlogResponse
struct UserBlogResponse: Codable {
    let docs: [UserBlog]
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage, nextPage: JSONNull?
}

// MARK: - Doc
struct UserBlog: Codable {
    let id: String?
    let userID: UserID?
    let title: String!
    let content: String?
    let blogImage: [String]?
    let status: String?
    let reactionCount: Int?
    let deleted: Bool?
    let reaction: [Reaction]?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case title, content, blogImage, status, reactionCount, deleted, reaction, createdAt, updatedAt
        case v = "__v"
    }
}
