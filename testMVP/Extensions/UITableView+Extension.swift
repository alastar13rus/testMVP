//
//  UITableView+Extension.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import UIKit

extension UITableView {
    
    func reloadDataWithAnimation(newList: [PostData], oldList: [PostData]) {
        
        self.beginUpdates()
        
        if newList.count > oldList.count {
            let insertingRows = Array(oldList.count ..< newList.count)
            let insertingIndexPaths = insertingRows.map { IndexPath(row: $0, section: 0) }
            self.insertRows(at: insertingIndexPaths, with: .left)
            
        } else if newList.count < oldList.count {
            let deletingRows = Array(newList.count ..< oldList.count)
            let deletingIndexPaths = deletingRows.map { IndexPath(row: $0, section: 0) }
            self.deleteRows(at: deletingIndexPaths, with: .right)
        }
        
        self.endUpdates()
    }
    
    func calculateTextLabelHeight(withContent content: String, font: UIFont) -> CGFloat {
        let stringSize = CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)
        let string = NSAttributedString(string: content, attributes: [.font: font])
        let stringBox = string.boundingRect(with: stringSize, options: .usesLineFragmentOrigin, context: nil)
        
        return stringBox.height
    }
}
