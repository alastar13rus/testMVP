//
//  CustomImageView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 27.06.2021.
//

import UIKit

class CustomImageView: UIImageView {
    
    let cache = ImageCacheProvider.shared
    var currentImageURL: URL?
    
    func setImage(_ url: URL?, completion: ((Bool) -> Void)? = nil) {
        
        guard let url = url else {
            completion?(false)
            return
        }
        self.currentImageURL = url
        self.image = nil
        
        if let image = cache[url] {
            self.image = image
            completion?(true)
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return DispatchQueue.main.async { completion?(false) }
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    return DispatchQueue.main.async { completion?(false) }
                }
                self.cache[url] = UIImage(data: data)
                
                DispatchQueue.main.async {
                    guard self.currentImageURL == url else { return completion!(false) }
                    self.image = UIImage(data: data)
                    completion?(true)
                    return 
                }
            }
            task.resume()
        }
    }
}
