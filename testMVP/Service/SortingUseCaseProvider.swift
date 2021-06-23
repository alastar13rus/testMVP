//
//  SortingUseCaseProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import Foundation

protocol SortingUseCaseProvider: class {
    
    typealias Cursor = String
    
    func fetchSortingItems() -> [SortingData]
    func fetchSelectedSorting() -> Sorting
    
    func saveSelectedSorting(_ sorting: Sorting)
    func saveDefaultSelectedSorting() -> Sorting
    func saveSortingItems(_ sortingItems: [SortingData]) -> [SortingData]
    
    func saveDefaultSortingItems() -> [SortingData]

}
