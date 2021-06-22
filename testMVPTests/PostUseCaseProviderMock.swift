//
//  PostUseCaseProviderMock.swift
//  testMVPTests
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import Foundation
@testable import testMVP

class PostUseCaseProviderMock: PostUseCaseProvider {
    
    private(set) var numberOfStartsFetchFirstPostsMethod = 0
    private(set) var numberOfStartsFetchAfterPostsMethod = 0

    func fetchFirstPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        numberOfStartsFetchFirstPostsMethod += 1
        repository("fetchFirstPosts_\(request.first)_\(request.orderBy)") { completion($0) }
    }
    
    func fetchAfterPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        numberOfStartsFetchAfterPostsMethod += 1
        repository(request.after!) { completion($0) }
    }
    
    func fetchPostDetail(_ detailID: String, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        
        let post = Post(id: "1", status: .published, type: .plain, contents: [], createdAt: 1, updatedAt: 1, author: nil, stats: Stats(likes: StatInfo(count: 0), views: StatInfo(count: 0), comments: StatInfo(count: 0), shares: StatInfo(count: 0), replies: StatInfo(count: 0)), isMyFavorite: false)
        
        let postResponse = PostResponse(data: post)
        completion(.success(postResponse))
    
    }

    func repository<T: Decodable>(_ filename: String, _ completion: @escaping (Result<T, Error>) -> Void) {
        let filename = filename.replacingOccurrences(of: "/", with: ":")
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: filename, ofType: "json")
        let json = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let decodedModel = try! JSONDecoder().decode(T.self, from: json)
        let result: Result<T, Error> = .success(decodedModel)
        completion(result)
    }
}
