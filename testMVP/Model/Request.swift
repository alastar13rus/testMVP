//
//  Request.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import Foundation

struct Request {
    typealias Cursor = String
    
    let first: Int
    let after: Cursor?
    let orderBy: Sorting
}

enum Sorting: String {
    case mostPopular
    case mostCommented
    case createdAt
}
