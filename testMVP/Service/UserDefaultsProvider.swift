//
//  UserDefaultsProvider.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import Foundation

class UserDefaultsProvider: SortingUseCaseProvider {
    
    struct KeyDefaults {
        static let selectedSortingItem = "selectedSortingItem"
        static let sortingItems = "sortingItems"
    }
    
//    MARK: - Properties
    static let shared = UserDefaultsProvider()
    let userDefaults = UserDefaults.standard
    
//    MARK: - Init
    private init() { }
    
//    MARK: - Methods
    func fetchSortingItems() -> [SortingData] {
        
        guard let data = userDefaults.data(forKey: KeyDefaults.sortingItems) else {
            return saveDefaultSortingItems()
        }
        
        do {
            let decodedSortingItems = try JSONDecoder().decode([SortingData].self, from: data)
            if decodedSortingItems.isEmpty { return saveDefaultSortingItems() }
            return decodedSortingItems
            
        } catch {
            fatalError("Ошибка декодирования данных в UserDefaults")
        }
    }
    
    
    
    func fetchSelectedSorting() -> Sorting {
        
        guard let data = userDefaults.data(forKey: KeyDefaults.selectedSortingItem) else {
            return saveDefaultSelectedSorting()
        }
        
        do {
            let decodedSortingItem = try JSONDecoder().decode(Sorting.self, from: data)
            return decodedSortingItem
        } catch {
            fatalError("Ошибка декодирования данных в UserDefaults")
        }
    }
    
    func saveSortingItems(_ sortingItems: [SortingData]) -> [SortingData] {
        
        do {
            let encodedSortingItems = try JSONEncoder().encode(sortingItems)
            userDefaults.set(encodedSortingItems, forKey: KeyDefaults.sortingItems)
            return sortingItems
        } catch {
            fatalError("Ошибка при сохранении в UserDefaults")
        }
    }
    
    func saveDefaultSortingItems() -> [SortingData] {
        let sortingItems: [SortingData] = [
            .init(sortingType: .createdAt, isSelected: true),
            .init(sortingType: .mostCommented, isSelected: false),
            .init(sortingType: .mostPopular, isSelected: false)
        ]
        return saveSortingItems(sortingItems)
    }
    
    func saveDefaultSelectedSorting() -> Sorting {
        return .createdAt
    }
    
    func saveSelectedSorting(_ sorting: Sorting) {
        
        do {
            let encodedSorting = try JSONEncoder().encode(sorting)
            userDefaults.set(encodedSorting, forKey: KeyDefaults.selectedSortingItem)
        } catch {
            fatalError("Ошибка при сохранении в UserDefaults")
        }
    }
}

extension Sorting: Encodable, Decodable { }
