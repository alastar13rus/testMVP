//
//  SortingTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 19.06.2021.
//

import UIKit

class SortingTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var data: SortingData! {
        didSet {
            configure(with: data)
        }
    }
    
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
//    }
    
//    MARK: - Methods
    private func configure(with data: SortingData) {
        textLabel?.text = data.name
        
        accessoryType = (data.isSelected) ? .checkmark : .none
        layoutIfNeeded()
    }
}
