//
//  PostUseCaseProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

protocol PostUseCaseProvider: class {
    
    typealias Cursor = String
    
    func fetchFirstPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void)
    func fetchAfterPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void)
    
}