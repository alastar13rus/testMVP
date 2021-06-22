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
    func didRefreshTriggerFired()
    func presentSortingSettings()
    func didSelectItemTrigger(_ selectedItem: PostData)
    
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
    var router: PostListRoutable?
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
    }
    
    
//    MARK: - Methods
    
    func didFirstPageTriggerFired() {
        guard !isFetching else { return }
        isFetching = true
        
        sortingUseCaseProvider.fetchSelectedSorting { [weak self] (selectedSorting) in
            guard let self = self else { return }
            
            guard self.sorting != selectedSorting else {
                self.isFetching = false
                return
            }
            
            if selectedSorting != nil {
                self.sorting = selectedSorting!
            } else {
                self.sortingUseCaseProvider.saveSelectedSorting(self.sorting, completion: nil)
            }
            
            let request = Request(first: self.state.perPage, after: nil, orderBy: self.sorting)
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
    
    func didRefreshTriggerFired() {
        guard !isFetching else { return }
        isFetching = true
        let request = Request(first: self.state.perPage, after: nil, orderBy: self.sorting)
        self.useCaseProvider.fetchFirstPosts(request) { [weak self] in
            self?.handle($0, isReplace: true)
        }
    }
    
    func presentSortingSettings() {
        router?.toSortingScreen()
    }
    
    func didSelectItemTrigger(_ selectedItem: PostData) {
        router?.toPostDetailScreen(with: selectedItem.id)
    }
    
    
    func handle(_ result: Result<PostListResponse, Error>, isReplace: Bool) {
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
            print(error.localizedDescription)
        }
    }
    
    func removeAllPosts() {
        self.posts.removeAll()
    }
    
    func setupFetchingStatus(_ newStatus: Bool) {
        self.isFetching = newStatus
    }
    
    func setupState(newState: State) {
        self.state = newState
    }
    
    func setupSorting(_ newSorting: Sorting) {
        self.sorting = newSorting
    }
}
