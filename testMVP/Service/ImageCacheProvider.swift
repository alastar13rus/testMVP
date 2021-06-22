//
//  ImageCacheProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import UIKit

class ImageCacheProvider {
    
//    MARK: - Properties
    static let shared = ImageCacheProvider()
    let imageCache = NSCache<NSString, UIImage>()
    let lock = NSLock()
    
//    MARK: - Init
    private init() { }
    
//    MARK: - Subscript
    subscript(_ url: URL) -> UIImage? {
        get {
//            print("\nЗапрос из кэша. \n\tКлюч:\t\(url)\n")
            return image(for: url)
        }
        set {
//            print("\nЗапись в кэш. \n\tКлюч:\t\(url)\n")
            insertImage(newValue, for: url)
        }
    }
    
//    MARK: - Methods
    func image(for url: URL) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        guard let image = imageCache.object(forKey: url.absoluteString as NSString) else { return nil }
        print("\nПолучение из кэша. \n\tКлюч:\t\(url)\n")
        return image
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        
        lock.lock()
        defer { lock.unlock() }
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func removeImage(for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        imageCache.removeObject(forKey: url.absoluteString as NSString)
    }
}
