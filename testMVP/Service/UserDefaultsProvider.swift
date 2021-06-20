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
    func fetchSortingItems(_ completion: @escaping ([SortingData]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let self = self else { return }
            
            guard let data = self.userDefaults.data(forKey: KeyDefaults.sortingItems) else {
                self.saveDefaultSortingItems { completion($0) }
                return
            }
            
            do {
                let decodedSortingItems = try JSONDecoder().decode([SortingData].self, from: data)
                
                if decodedSortingItems.isEmpty { self.saveDefaultSortingItems { completion($0) } }
                
                DispatchQueue.main.sync { completion(decodedSortingItems) }
                
            } catch {
                fatalError("Ошибка декодирования данных в UserDefaults")
            }
        }
    }

    
    func fetchSelectedSorting(_ completion: @escaping (Sorting?) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            guard let data = self.userDefaults.data(forKey: KeyDefaults.selectedSortingItem) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            do {
                let decodedSortingItem = try JSONDecoder().decode(Sorting.self, from: data)
                DispatchQueue.main.async { completion(decodedSortingItem) }
            } catch {
                fatalError("Ошибка декодирования данных в UserDefaults")
            }
        }
    }
    
    func saveSortingItems(_ sortingItems: [SortingData], _ completion: @escaping ([SortingData]) -> Void) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let encodedSortingItems = try JSONEncoder().encode(sortingItems)
                self.userDefaults.set(encodedSortingItems, forKey: KeyDefaults.sortingItems)
                DispatchQueue.main.async { completion(sortingItems) }
            } catch {
                fatalError("Ошибка при сохранении в UserDefaults")
            }
        }
    }
    
    func saveDefaultSortingItems(_ completion: @escaping ([SortingData]) -> Void) {
        let sortingItems: [SortingData] = [
            .init(sortingType: .createdAt, isSelected: true),
            .init(sortingType: .mostCommented, isSelected: false),
            .init(sortingType: .mostPopular, isSelected: false)
        ]
        saveSortingItems(sortingItems) {  completion($0) }
    }
    
    func saveSelectedSorting(_ sorting: Sorting, completion: (() -> Void)?) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            do {
                let encodedSorting = try JSONEncoder().encode(sorting)
                self.userDefaults.set(encodedSorting, forKey: KeyDefaults.selectedSortingItem)
                completion?()
            } catch {
                fatalError("Ошибка при сохранении в UserDefaults")
            }
        }
        
    }
}

extension Sorting: Encodable, Decodable { }
