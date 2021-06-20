//
//  PostListPresenter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

protocol PostListPresenterProtocol: class {
    var posts: [PostData] { get }
    var state: State { get }
    var sortingName: String { get }
    
    func didFirstPageTriggerFired()
    func didNextPageTriggerFired()
    func presentSortingSettings()
    
}

struct State {
    var perPage: Int
    var currentCursor: String?
}

class PostListPresenter: PostListPresenterProtocol {
    
    typealias Cursor = String
    
//    MARK: - Properties
    let useCaseProvider: PostUseCaseProvider
    let sortingUseCaseProvider: SortingUseCaseProvider
    var router: PostListRouter?
    weak var delegate: PostListView?
    
    private(set) var posts = [PostData]()
    
    private(set) var state = State(perPage: 10,
                                   currentCursor: nil)
    
    private(set) var sorting: Sorting = .mostPopular {
        didSet {
            delegate?.updateSortingName()
        }
    }
    
    private(set) var isFetching: Bool = false {
        didSet {
            delegate?.updateFetchingStatus(isFetching)
        }
    }

    var sortingName: String {
        SortingData(sortingType: sorting, isSelected: false).name
    }
    
    
//    MARK: - Init
    init(useCaseProvider: PostUseCaseProvider, sortingUseCaseProvider: SortingUseCaseProvider, delegate: PostListView?) {
        self.useCaseProvider = useCaseProvider
        self.sortingUseCaseProvider = sortingUseCaseProvider
        self.delegate = delegate
        
        self.didFirstPageTriggerFired()
    }
    
    
//    MARK: - Methods
    
    func didFirstPageTriggerFired() {
        guard !isFetching else { return }
        isFetching = true
        
        sortingUseCaseProvider.fetchSelectedSorting { [weak self] (sorting) in
            guard let self = self, let sorting = sorting else { return }
            
//            guard self.sorting != sorting else {
//                self.isFetching = false
//                return
//            }
            self.sorting = sorting
            
            let request = Request(first: self.state.perPage, after: nil, orderBy: sorting)
            self.useCaseProvider.fetchFirstPosts(request) { [weak self] in
                self?.handle($0, isReplace: true)
            }
        }
    }
    
    func didNextPageTriggerFired() {
        guard !isFetching else { return }
        isFetching = true
        
        guard let cursor = state.currentCursor else {
            isFetching = false
            return
        }
        
        let request = Request(first: state.perPage, after: cursor, orderBy: sorting)
        useCaseProvider.fetchAfterPosts(request) { [weak self] in
            self?.handle($0, isReplace: false)
        }
    }
    
    func presentSortingSettings() {
        router?.toSortingScreen()
    }
    
    private func handle(_ result: Result<PostListResponse, Error>, isReplace: Bool) {
        switch result {
        case .success(let response):
            self.state.currentCursor = response.data.cursor
            
            if isReplace {
                self.posts = response.data.items.map { PostData($0) }
                isFetching = false
                delegate?.updateData()
            } else {
                let oldValue = self.posts
                self.posts += response.data.items.map { PostData($0) }
                isFetching = false
                delegate?.updatePartialData(newList: posts, oldList: oldValue)
            }
            
        case .failure(let error):
            fatalError(error.localizedDescription)
        print(error.localizedDescription)
        }
    }
    
}
