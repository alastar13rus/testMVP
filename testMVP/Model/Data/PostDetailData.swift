//
//  PostDetailData.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 21.06.2021.
//

import Foundation

struct PostDetailData {
    let id: String
//    let status: PostStatus
    let type: PostType
    let typeString: String
    let contents: [PostContent]
    let contentsString: String
    let createdAtDate: Date
    let updatedAtDate: Date
//    let author: Author
    let stats: Stats
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
    
    var cellFooterHeight: Int {
        updatedAtString == "" ? 20: 48
    }
    
    var cellHeaderHeight: Int { 72 }
    
    var cellPaddings: Int { 48 }
    
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
                images.append(content.medium?.url ?? content.small?.url)
            
            case .imageGif(let content):
                imageGif = content.medium?.url ?? content.small?.url ?? content.extraSmall?.url
            
            case .audio(let content):
                audio = (url: content.url,
                         duration: "Продолжительность: \(ceil(content.duration * 100) / 100) сек")
            
            case .video(let content):
                video = (url: content.url,
                         duration: "Продолжительность: \(ceil(content.duration * 100) / 100) сек",
                         previewImageURL: content.previewImage.data.medium?.url)
            
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

        self.stats = Stats(likes: model.stats.likes,
                           views: model.stats.views,
                           comments: model.stats.comments,
                           shares: model.stats.shares,
                           replies: model.stats.replies)
    }
}

extension PostDetailData: Equatable {
    static func == (lhs: PostDetailData, rhs: PostDetailData) -> Bool {
        return lhs.id == rhs.id
    }
}

extension PostDetailData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
