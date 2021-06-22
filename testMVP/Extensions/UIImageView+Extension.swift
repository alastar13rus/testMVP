//
//  UIImageView+Extension.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import UIKit

extension UIImageView {
    
    func setImage(with url: URL?, _ completion: ((Bool) -> Void)? = nil) {
        
        let cacheProvider = ImageCacheProvider.shared
        let urlSession = URLSession.shared
        
        DispatchQueue.global(qos: .background).async {
            
            guard let url = url else {
                DispatchQueue.main.async { completion?(false) }
                return
            }
            
            guard let image = cacheProvider[url] else {
                
                let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
                    
                    guard error == nil, let data = data, let image = UIImage(data: data) else {
                        DispatchQueue.main.async { completion?(false) }
                        return
                    }
                    
                    cacheProvider[url] = image
                    DispatchQueue.main.async { self.image = image; completion?(true) }
                    
                }
                
                dataTask.resume()
                return
            }
            DispatchQueue.main.async { self.image = image; completion?(true) }
            
        }
    }
}
