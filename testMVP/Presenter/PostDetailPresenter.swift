//
//  PostDetailPresenter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 20.06.2021.
//

import Foundation

protocol PostDetailPresenterProtocol {
    
}

class PostDetailPresenter: PostDetailPresenterProtocol {
    
//    MARK: - Properties
    let detailID: String
    let useCaseProvider: PostUseCaseProvider
    weak var delegate: PostDetailView?
    var router: PostListRouter?
    
    var postDetailData: PostDetailData! {
        didSet {
            guard let data = postDetailData else { return }
            delegate?.updateData(with: data)
        }
    }
    
    
//    MARK: - Init
    init(detailID: String, useCaseProvider: PostUseCaseProvider, delegate: PostDetailView?) {
        self.detailID = detailID
        self.useCaseProvider = useCaseProvider
        self.delegate = delegate
        
        fetchPostDetail(detailID)
    }
    
    
//    MARK: - Methods
    func fetchPostDetail(_ detailID: String) {
        useCaseProvider.fetchPostDetail(detailID) { [weak self] (result) in
            self?.handle(result)
        }
    }
    
    private func handle(_ result: Result<PostResponse, Error>) {
        switch result {
        case .success(let postDetail):
            self.postDetailData = PostDetailData(postDetail.data)
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    
}
