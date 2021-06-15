//
//  NetworkAgent.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

class NetworkAgent {
    
    static let shared = NetworkAgent()
    
    private init() { }
    
    func request<T: Decodable>(_ url: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.global(qos: .background).async {
                
                guard error == nil else { return }
                guard response != nil else { return }
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
