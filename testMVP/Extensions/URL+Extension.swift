//
//  URL+Extension.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

extension URL {
    func downloadImageData(_ completion: @escaping (Data?) -> Void) {
        print(self)
        DispatchQueue.global(qos: .background).async {
            let dataTask = URLSession.shared.dataTask(with: self) { (data, _, error) in
                
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            dataTask.resume()
        }
    }
}
