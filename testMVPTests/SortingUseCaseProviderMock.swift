//
//  SortingUseCaseProviderMock.swift
//  testMVPTests
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import Foundation
@testable import testMVP

class SortingUseCaseProviderMock: SortingUseCaseProvider {
    
    
//    MARK: - Properties
    var selectedSorting: Sorting!
    
    
//    MARK: - Init
    init(selectedSorting: Sorting?) {
        self.selectedSorting = selectedSorting
    }
    
    
//    MARK: - Methods
    
    func fetchSortingItems() -> [SortingData] {
        return []
    }
    
    func fetchSelectedSorting() -> Sorting {
        return selectedSorting ?? saveDefaultSelectedSorting()
    }
    
    func saveSelectedSorting(_ sorting: Sorting) {
        self.selectedSorting = sorting
    }
    
    func saveSortingItems(_ sortingItems: [SortingData]) -> [SortingData] {
        return []
    }
    
    func saveDefaultSortingItems() -> [SortingData] {
        return []
    }
    
    func saveDefaultSelectedSorting() -> Sorting {
        return .createdAt
    }
    
    
    
    
}
