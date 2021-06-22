//
//  PostListRouterMock.swift
//  testMVPTests
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import Foundation
@testable import testMVP

class PostListRouterMock: PostListRoutable {
    
    private(set) var numberOfStartToPostDetailScreenMethod = 0
    private(set) var numberOfStartToSortingScreenMethod = 0

    func toPostDetailScreen(with detailID: String) {
        numberOfStartToPostDetailScreenMethod += 1
    }
    
    func toSortingScreen() {
        numberOfStartToSortingScreenMethod += 1
    }
    
    
}
