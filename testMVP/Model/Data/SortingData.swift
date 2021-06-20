//
//  SortingData.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 19.06.2021.
//

import Foundation

struct SortingData: Decodable, Encodable {
    
    let sortingType: Sorting
    private(set) var isSelected: Bool
    
    var name: String {
        switch sortingType {
        case .createdAt: return "По дате создания"
        case .mostCommented: return "По количеству комментариев"
        case .mostPopular: return "По популярности"
        }
    }
    
    mutating func changeSelection(to isSelected: Bool) {
        self.isSelected = isSelected
    }
}

extension SortingData: Equatable {
    static func ==(lhs: SortingData, rhs: SortingData) -> Bool {
        return lhs.sortingType == rhs.sortingType && lhs.isSelected == rhs.isSelected
    }
}
