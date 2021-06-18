//
//  Date.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

extension Date {
    
    func toMediumString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.locale = Locale(identifier: "RU")
        return formatter.string(from: self)
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.locale = Locale(identifier: "RU")
        return formatter.string(from: self)
    }
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.dateStyle = DateFormatter.Style.none
        formatter.locale = Locale(identifier: "RU")
        return formatter.string(from: self)
    }
}
