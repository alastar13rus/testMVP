//
//  Gender+Extension.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import UIKit

extension Optional where Wrapped == Gender {
    
    func getImage() -> UIImage {
        
        switch self {
        case .male: return #imageLiteral(resourceName: "menPlaceholder").withTintColor(.systemGray5)
        case .female: return #imageLiteral(resourceName: "womanPlaceholder").withTintColor(.systemGray5)
        default: return #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray5)
        }
    }
    
    
}
