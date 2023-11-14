////
////  PopularBlog.swift
////  S-Forum
////
////  Created by Fakunabs on 13/11/2023.
////
//
import Foundation

// MARK: - PopularBlogResponse
struct PopularBlogResponse: Codable {
    let paginatedResult: PaginatedResult?
}

// MARK: - PaginatedResult
struct PaginatedResult: Codable {
    let docs: [PopularBlog]?
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage, nextPage: JSONNull?
}
//
// MARK: - Doc
struct PopularBlog: Codable {
    let id, userID, title, content: String?
    let blogImage: [String]?
    let deleted: Bool?
    let reaction: [Reaction]?
    let createdAt, updatedAt: String?
    let v: Int?
    let status, category: String?
    let reactionCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case title, content, blogImage, deleted, reaction, createdAt, updatedAt
        case v = "__v"
        case status, category, reactionCount
    }
}

