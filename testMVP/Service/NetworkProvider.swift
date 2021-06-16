//
//  NetworkProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

class NetworkProvider: UseCaseProvider {
    
    static let baseURL = "k8s-stage.apianon.ru"
    let networkAgent: NetworkAgent
    
    init(networkAgent: NetworkAgent) {
        self.networkAgent = NetworkAgent.shared
    }
    
    
    func fetchFirstPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Self.baseURL
        urlComponents.path = "/posts/v1/posts"
        urlComponents.queryItems = [
            .init(name: "first", value: "\(request.first)"),
            .init(name: "orderBy", value: request.orderBy.rawValue)
        ]

        guard let url = urlComponents.url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        networkAgent.request(url) { completion($0) }
    }
    
    func fetchAfterPosts(_ request: Request, completion: @escaping (Result<PostListResponse, Error>) -> Void) {
        
        guard let after = request.after else {
            completion(.failure(CustomError.missingRequestParams))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Self.baseURL
        urlComponents.path = "/posts/v1/posts"
        urlComponents.queryItems = [
            .init(name: "first", value: "\(request.first)"),
            .init(name: "after", value: after),
            .init(name: "orderBy", value: request.orderBy.rawValue)
        ]

        guard let url = urlComponents.url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        networkAgent.request(url) { completion($0) }
    }
    
}
