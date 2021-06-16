//
//  PostListPresenter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

protocol PostListPresenterProtocol: class {
    
    
    
}

class PostListPresenter: PostListPresenterProtocol {
    
    typealias Cursor = String
    
//    MARK: - Properties
    let useCaseProvider: UseCaseProvider
    weak var delegate: PostListView?
    
    var posts = [Post]()
    var currentCursor: Cursor? = nil
    let first = 20
    let sorting: Sorting = .createdAt
    
    
//    MARK: - Init
    init(useCaseProvider: UseCaseProvider, delegate: PostListView?) {
        self.useCaseProvider = useCaseProvider
        self.delegate = delegate
    }
    
    
//    MARK: - Methods
    func fetch() {
        
        guard let cursor = currentCursor else {
            let request = Request(first: first, after: nil, orderBy: sorting)
            useCaseProvider.fetchFirstPosts(request) { [weak self] in self?.handle($0) }
            return
        }
        
        let request = Request(first: first, after: cursor, orderBy: sorting)
        useCaseProvider.fetchAfterPosts(request) { [weak self] in self?.handle($0) }
    }
    
    func handle(_ result: Result<PostListResponse, Error>) {
        switch result {
        case .success(let response):
            self.currentCursor = response.data.cursor
            self.posts = response.data.items
            
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
}
