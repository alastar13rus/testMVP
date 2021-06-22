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
    
    func fetchSortingItems(_ completion: @escaping ([SortingData]) -> Void) {

    }
    
    func fetchSelectedSorting(_ completion: @escaping (Sorting?) -> Void) {
        completion(selectedSorting)
    }
    
    func saveSelectedSorting(_ sorting: Sorting, completion: (() -> Void)?) {
        self.selectedSorting = sorting
    }
    
    func saveSortingItems(_ sortingItems: [SortingData], _ completion: @escaping ([SortingData]) -> Void) {
        
    }
    
    func saveDefaultSortingItems(_ completion: @escaping ([SortingData]) -> Void) {
        
    }
    
    
    
    
}
