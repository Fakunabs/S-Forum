//
//  PopularBlog.swift
//  S-Forum
//
//  Created by Fakunabs on 13/11/2023.
//

import Foundation

// MARK: - NewestBlogResponse
struct PopularBlogResponse: Codable {
    let docs: [PopularBlog]
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage: JSONNull?
    let nextPage: Int?
}

// MARK: - Doc
struct PopularBlog: Codable {
    let id: String?
    let userID: UserID?
    let category: Category?
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
        case category, title, content, blogImage, status, reactionCount, deleted, reaction, createdAt, updatedAt
        case v = "__v"
    }
}

