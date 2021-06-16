//
//  Post.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

enum PostStatus: String, Decodable {
    case published = "PUBLISHED"
}

enum PostType: String, Decodable {
    case plain = "PLAIN"
}

enum PostContentType: String, Decodable {
    case text = "TEXT"
}

struct PostContent: Decodable {
    let data: PostContentData
    let type: PostContentType
}

struct PostContentData: Decodable {
    let value: String
}

struct Author: Decodable {
    let id: String
    let name: String
    let banner: Banner
}

struct Banner: Decodable {
    let id: String
    let data: AuthorImageData
}

struct Photo: Decodable {
    let id: String
    let data: AuthorImageData
}

struct AuthorImageData: Decodable {
    let extraSmall: ImageInfo
    let small: ImageInfo
    let medium: ImageInfo
    let large: ImageInfo
    let original: ImageInfo
}

struct ImageInfo: Decodable {
    let url: String
    let size: Size
}

struct Size: Decodable {
    let width: Int
    let height: Int
}

struct Stats: Decodable {
    let likes: StatInfo
    let views: StatInfo
    let comments: StatInfo
    let shares: StatInfo
    let replies: StatInfo
}

struct StatInfo: Decodable {
    let count: Int
}




struct Post: Decodable {
    let id: String
    let status: PostStatus
    let type: PostType
    let contents: [PostContent]
    let createdAt: Int
    let updatedAt: Int
    let author: Author
    let stats: Stats
    let isMyFavorite: Bool
}

struct PostListResponseData: Decodable {
    let items: [Post]
    let cursor: String
}

struct PostListResponse: Decodable {
    let data: PostListResponseData
}
