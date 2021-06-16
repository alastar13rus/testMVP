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
    case plainCover = "PLAIN_COVER"
    case audioCover = "AUDIO_COVER"
    case image = "IMAGE"
    case video = "VIDEO"

}

enum PostContentType: String, Decodable {
    case text = "TEXT"
    case image = "IMAGE"
    case imageGif = "IMAGE_GIF"
    case audio = "AUDIO"
    case video = "VIDEO"
    case tags = "TAGS"
}

enum PostContent: Decodable {
    case text(TextData)
    case image(ImageData)
    case imageGif(ImageData)
    case audio(AudioData)
    case video(VideoData)
    case tags(TagData)

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(PostContentType.self, forKey: .type)
        switch type {
        case .text:
            self = .text(try container.decode(TextData.self, forKey: .data))
        case .image:
            self = .image(try container.decode(ImageData.self, forKey: .data))
        case .imageGif:
            self = .imageGif(try container.decode(ImageData.self, forKey: .data))
        case .audio:
            self = .audio(try container.decode(AudioData.self, forKey: .data))
        case .video:
            self = .video(try container.decode(VideoData.self, forKey: .data))
        case .tags:
            self = .tags(try container.decode(TagData.self, forKey: .data))
        }
    }
}

struct Author: Decodable {
    let id: String
    let name: String
    let banner: Banner?
}

struct Banner: Decodable {
    let id: String
    let data: ImageData
}

struct Photo: Decodable {
    let id: String
    let data: ImageData
}

struct PreviewImage: Decodable {
    let id: String
    let data: ImageData
}

struct ImageData: Decodable {
    let extraSmall: ImageInfo?
    let small: ImageInfo?
    let medium: ImageInfo?
    let large: ImageInfo?
    let original: ImageInfo?
}

struct TextData: Decodable {
    let value: String
}

struct AudioData: Decodable {
    let duration: Float
    let url: URL
}

struct VideoData: Decodable {
    let duration: Float
    let url: URL
    let size: Size
    let previewImage: PreviewImage
}

struct TagData: Decodable {
    let values: [String]
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
    let cursor: String?
}

struct PostListResponse: Decodable {
    let data: PostListResponseData
}
