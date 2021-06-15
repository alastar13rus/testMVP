//
//  NetworkProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

class NetworkProvider: UseCaseProvider {
    
    static let baseURL = "k8s-stage.apianon.ru/posts/v1"
    let networkAgent: NetworkAgent
    
    init(networkAgent: NetworkAgent) {
        self.networkAgent = NetworkAgent.shared
    }
    
    
    func fetchFirstPosts(first: Int, orderBy: Sorting, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Self.baseURL
        urlComponents.path = "/posts"
        urlComponents.queryItems = [
            .init(name: "first", value: "\(first)"),
            .init(name: "orderBy", value: "\(orderBy)")
        ]

        guard let url = urlComponents.url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        networkAgent.request(url) { completion($0) }
    }
    
    func fetchAfterPosts(first: Int, after: Cursor, orderBy: Sorting, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Self.baseURL
        urlComponents.path = "/posts"
        urlComponents.queryItems = [
            .init(name: "first", value: "\(first)"),
            .init(name: "after", value: "\(after)"),
            .init(name: "orderBy", value: "\(orderBy)")
        ]

        guard let url = urlComponents.url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        networkAgent.request(url) { completion($0) }
    }
    
}
