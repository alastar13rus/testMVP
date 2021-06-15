//
//  UseCaseProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

protocol UseCaseProvider: class {
    
    typealias Cursor = String
    
    func fetchFirstPosts(first: Int, orderBy: Sorting, completion: @escaping (Result<PostListResponse, Error>) -> Void)
    func fetchAfterPosts(first: Int, after: Cursor, orderBy: Sorting, completion: @escaping (Result<PostListResponse, Error>) -> Void)
    
}
