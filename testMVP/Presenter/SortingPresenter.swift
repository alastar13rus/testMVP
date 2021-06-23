//
//  SortingPresenter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import Foundation

protocol SortingPresenterProtocol: class {
    
    var sortingItems: [SortingData] { get }
    var selectedItem: SortingData? { get }
    
    func showSortingItemsTrigger()
    func saveSelectedSortingByIndexTrigger(_ selectedItem: SortingData)

}

class SortingPresenter: SortingPresenterProtocol {
    
//    MARK: - Properties
    let useCaseProvider: SortingUseCaseProvider
    var router: PostListRouter?
    weak var delegate: SortingView?
    
    private(set) var sortingItems: [SortingData] = [] {
        didSet {
            print("sortingItems: \n\n \(sortingItems)")
            delegate?.updateData()
        }
    }
    
    var selectedItem: SortingData? = nil
    
    
    
//    MARK: - Init
    init(useCaseProvider: SortingUseCaseProvider, delegate: SortingView?) {
        self.useCaseProvider = useCaseProvider
        self.delegate = delegate
        
        
        
    }
    
    
//    MARK: - Methods
    func showSortingItemsTrigger() {
        self.sortingItems = fetchSortingItems()
    }
    
    
    func saveSelectedSortingByIndexTrigger(_ selectedItem: SortingData) {
        
        guard selectedItem != self.selectedItem else { return }
        
        let newSortingItems: [SortingData] = sortingItems.map {
            if $0.sortingType == selectedItem.sortingType {
                return SortingData(sortingType: $0.sortingType, isSelected: true)
            }  else {
                return SortingData(sortingType: $0.sortingType, isSelected: false)
            }
        }
        
        _ = saveSortingItems(newSortingItems)
        sortingItems = newSortingItems
        saveSelectedSorting(selectedItem)
    }
    
    private func fetchSortingItems() -> [SortingData] {
        useCaseProvider.fetchSortingItems()
    }
    
    private func saveDefaultSortingItems() -> [SortingData] {
        useCaseProvider.saveDefaultSortingItems()
    }
    
    private func saveSortingItems(_ sortingItems: [SortingData]) -> [SortingData] {
        useCaseProvider.saveSortingItems(sortingItems)
    }
    
    private func saveSelectedSorting(_ sorting: SortingData) {
        useCaseProvider.saveSelectedSorting(sorting.sortingType)
    }
    
}
