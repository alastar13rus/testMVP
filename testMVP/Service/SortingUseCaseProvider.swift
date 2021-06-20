//
//  SortingUseCaseProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import Foundation

protocol SortingUseCaseProvider: class {
    
    typealias Cursor = String
    
    func fetchSortingItems(_ completion: @escaping ([SortingData]) -> Void)
    func fetchSelectedSorting(_ completion: @escaping (Sorting?) -> Void)
    
    func saveSelectedSorting(_ sorting: Sorting, completion: (() -> Void)?)
    func saveSortingItems(_ sortingItems: [SortingData], _ completion: @escaping ([SortingData]) -> Void)
    
    func saveDefaultSortingItems(_ completion: @escaping ([SortingData]) -> Void)

}
