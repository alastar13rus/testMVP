//
//  PostData.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

struct ContentVariantHeight {
    static let textHeight: Float = 0
    static let imageHeight: Float = 200
    static let imageGifHeight: Float = 200
    static let audioHeight: Float = 0
    static let videoHeight: Float = 200
    static let tagsHeight: Float = 0
    
    static func calcContentHeight(_ contents: [PostContent]) -> Float {
        var height: Float = 0.0
        var imageCount = 0
        contents.forEach {
            switch $0 {
            case .text: height += textHeight
            case .image: height += (imageCount == 0) ? imageHeight : 0; imageCount += 1
            case .imageGif: height += imageGifHeight
            case .tags: height += tagsHeight
            case .audio: height += audioHeight
            case .video: height += videoHeight
            }
        }
        return height
    }
}

struct PostData {
    let id: String
//    let status: PostStatus
    let type: PostType
    let typeString: String
    let contents: [PostContent]
    let contentsString: String
    let createdAtDate: Date
    let updatedAtDate: Date
//    let author: Author
//    let stats: Stats
    let isMyFavorite: Bool
    let authorName: String?
    let authorPhotoURL: URL?
    let authorGender: Gender?
    
    var textContent: String? = nil
    var imageContentURL: URL? = nil
    var secondImageContentURL: URL? = nil
    var imageGifContentURL: URL? = nil
    var audioContent: (url: URL, duration: String)? = nil
    var videoContent: (url: URL, duration: String, previewImageURL: URL?)? = nil
    var tagsContent: String? = nil

    var createdAtString: String { createdAtDate.toMediumString() }
    
    var updatedAtString: String {
        let createDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: createdAtDate)
        let updateDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: updatedAtDate)
        
        guard updatedAtDate != createdAtDate else { return "" }
        
        guard updateDateComponents == createDateComponents else {
            return " (Изм: \(updatedAtDate.toMediumString()))"
        }
        
        return " (Изм: \(updatedAtDate.toTimeString()))"
    }
    
    var cellContentHeight: Float {
        ContentVariantHeight.calcContentHeight(contents)
    }
    
    var cellFooterHeight: Float {
        updatedAtString == "" ? 20: 48
    }
    
    var cellHeaderHeight: Float { 72 }
    
    var cellPaddings: Float { 48 }
    
    init(_ model: Post) {
        self.id = model.id
        self.type = model.type
        self.typeString = model.type.rawValue
        self.createdAtDate = Date(timeIntervalSince1970: model.createdAt / 1000)
        self.updatedAtDate = Date(timeIntervalSince1970: model.updatedAt / 1000)
        self.isMyFavorite = model.isMyFavorite
        
        self.contents = model.contents
        
        var images = [URL?]()
        var audio: (url: URL, duration: String)?
        var video: (url: URL, duration: String, previewImageURL: URL?)?
        var imageGif: URL?
        var tags: String?
        
        model.contents.forEach {
            switch $0 {
            
            case .image(let content):
                images.append(content.small?.url ?? content.extraSmall?.url)
            
            case .imageGif(let content):
                imageGif = content.small?.url ?? content.extraSmall?.url
            
            case .audio(let content):
                audio = (url: content.url,
                         duration: "Продолжительность: \(ceil(content.duration * 100) / 100) сек")
            
            case .video(let content):
                let previewImage = content.previewImage.data.medium?.url ?? content.previewImage.data.small?.url ?? content.previewImage.data.extraSmall?.url
                video = (url: content.url,
                         duration: "Продолжительность: \(ceil(content.duration * 100) / 100) сек",
                         previewImageURL: previewImage)
            
            case .tags(let content):
                tags = content.values.joined(separator: " ,")
            default: return
            }
        }
        
        self.audioContent = audio
        self.videoContent = video
        self.imageGifContentURL = imageGif
        self.tagsContent = tags
        
        self.textContent = model.contents
            .compactMap { if case .text(let content) = $0 { return content.value } else { return nil } }
            .joined(separator: "\n")
        
        if let firstImage = images.first { self.imageContentURL = firstImage }
        if images.count > 1, let secondImage = images[1] { self.secondImageContentURL = secondImage }
        
        self.contentsString = model.contents.map {
            switch $0 {
            case .audio: return "audio"
            case .image: return "image"
            case .imageGif: return "imageGif"
            case .tags: return "tags"
            case .text: return "text"
            case .video: return "video"
            }
        }.joined(separator: " ,")
        
        self.authorName = model.author?.name
        self.authorPhotoURL = model.author?.photo?.data.small?.url ?? model.author?.photo?.data.extraSmall?.url
        self.authorGender = model.author?.gender
        
    }
}

extension PostData: Equatable {
    static func == (lhs: PostData, rhs: PostData) -> Bool {
        return lhs.id == rhs.id
    }
}

extension PostData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
