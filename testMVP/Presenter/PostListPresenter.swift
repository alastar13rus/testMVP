//
//  PostListPresenter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

protocol PostListPresenterProtocol: class {
    
    func didFirstPageTriggerFired()
    func didNextPageTriggerFired()
    
}

struct State {
    var perPage: Int
    var currentCursor: String?
    var sorting: Sorting
}

class PostListPresenter: PostListPresenterProtocol {
    
    typealias Cursor = String
    
//    MARK: - Properties
    let useCaseProvider: UseCaseProvider
    weak var delegate: PostListView?
    
    var posts = [PostData]() {
        didSet {
            print(posts.count)
            delegate?.updateData(newList: posts, oldList: oldValue)
        }
    }
    
    var state = State(perPage: 10, currentCursor: nil, sorting: .mostPopular)
    
    
//    MARK: - Init
    init(useCaseProvider: UseCaseProvider, delegate: PostListView?) {
        self.useCaseProvider = useCaseProvider
        self.delegate = delegate
    }
    
    
//    MARK: - Methods
    func didFirstPageTriggerFired() {
        let request = Request(first: state.perPage, after: nil, orderBy: state.sorting)
        useCaseProvider.fetchFirstPosts(request) { [weak self] in self?.handle($0, isReplace: true) }
    }
    
    func didNextPageTriggerFired() {
        guard let cursor = state.currentCursor else { return }
        let request = Request(first: state.perPage, after: cursor, orderBy: state.sorting)
        useCaseProvider.fetchAfterPosts(request) { [weak self] in self?.handle($0, isReplace: false) }
    }
    
    private func handle(_ result: Result<PostListResponse, Error>, isReplace: Bool) {
        switch result {
        case .success(let response):
            self.state.currentCursor = response.data.cursor
            
            if isReplace {
                self.posts = response.data.items.map { PostData($0) }
            } else {
                self.posts += response.data.items.map { PostData($0) }
            }
            
        case .failure(let error):
//            fatalError(error.localizedDescription)
        print(error.localizedDescription)
        }
    }
    
}
