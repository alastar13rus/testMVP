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
        fetchSortingItems { [weak self] in self?.sortingItems = $0 }
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
        
        saveSortingItems(newSortingItems) { [weak self] (items) in
            guard let self = self, newSortingItems != self.sortingItems else { return }
            self.sortingItems = newSortingItems
            self.saveSelectedSorting(selectedItem)
        }
    }
    
    private func fetchSortingItems(_ completion: @escaping ([SortingData]) -> Void) {
        useCaseProvider.fetchSortingItems { completion($0) }
    }
    
    private func saveDefaultSortingItems(_ completion: @escaping ([SortingData]) -> Void) {
        useCaseProvider.saveDefaultSortingItems() { completion($0) }
    }
    
    private func saveSortingItems(_ sortingItems: [SortingData], _ completion: @escaping ([SortingData]) -> Void) {
        useCaseProvider.saveSortingItems(sortingItems) { completion($0) }
    }
    
    private func saveSelectedSorting(_ sorting: SortingData) {
        useCaseProvider.saveSelectedSorting(sorting.sortingType, completion: nil)
    }
    
}
