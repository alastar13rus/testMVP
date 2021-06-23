//
//  PostListPresenterTest.swift
//  testMVPTests
//
//  Created by Докин Андрей (IOS) on 22.06.2021.
//

import XCTest
@testable import testMVP

class PostListPresenterTest: XCTestCase {
    
    var postUseCaseProvider: PostUseCaseProviderMock!
    var sortingUseCaseProvider: SortingUseCaseProviderMock!
    var postListRouter: PostListRouterMock!
    var postVistView: PostListViewMock!
    var presenter: PostListPresenter!

    override func setUpWithError() throws {
        postUseCaseProvider = PostUseCaseProviderMock()
    }

    override func tearDownWithError() throws {
        postUseCaseProvider = nil
        sortingUseCaseProvider = nil
        postListRouter = nil
        postVistView = nil
        presenter = nil
    }
    
    /// Проверка начальных параметров при инициализации
    func testInitStartProperties() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
        
        //        When
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        //        Then
        XCTAssertEqual(presenter.state, State(perPage: 10, currentCursor: nil))
        XCTAssertEqual(presenter.sorting, .createdAt)
        XCTAssertFalse(presenter.isFetching)
        XCTAssertTrue(presenter.posts.isEmpty)
        XCTAssertEqual(presenter.sortingName, "По дате создания")
    }
    
    /// Если isFetching установлен в true, запроса первой партии постов не происходит
    func test_didFirstPageTriggerFired_whenFetchingIsTrue_thenNoFetch() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
        presenter.setupFetchingStatus(true)
        
        //        When
        
        let expectation = self.expectation(description: #function)
        
        presenter.didFirstPageTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
    }
    
    /// Если isFetching установлен в false, selectedSorting совпадает с текущим, и есть загруженные посты, запроса первой партии постов не происходит
        func test_didFirstPageTriggerFired_whenFetchingIsFalse_andSortingIsTheSame_andPostsIsNotEmpty_thenNoFetch() throws {
            
            //        Given
            sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
            presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
            
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
            
            let expectation = self.expectation(description: #function)
            
            presenter.didFirstPageTriggerFired()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 3)
            XCTAssertFalse(presenter.posts.isEmpty)
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 1)

            
            //        When
            
            let expectation2 = self.expectation(description: #function)
            
            presenter.didFirstPageTriggerFired()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                expectation2.fulfill()
            }
            
            waitForExpectations(timeout: 3)
            
            //        Then
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 1)
            XCTAssertFalse(presenter.isFetching)
            
        }
    
    /// Если isFetching установлен в false, selectedSorting совпадает с текущим, но загруженных постов нет, происходит запрос первой партии постов
        func test_didFirstPageTriggerFired_whenFetchingIsFalse_andSortingIsTheSame_andPostsIsEmpty_thenFetchCompleted() throws {
            
            //        Given
            sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
            presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
            
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
            presenter.setupSorting(.createdAt)
            
            //        When
            
            let expectation = self.expectation(description: #function)
            
            presenter.didFirstPageTriggerFired()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 3)
            
            //        Then
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 1)
            XCTAssertFalse(presenter.isFetching)
            
        }
    
    /// Если isFetching установлен в false и текущая сортировка отличается от selectedSorting в UserDefaults, происходит запрос первой партии постов с режимом сортировки из UserDefaults и текущая сортировка изменяется на selectedSorting из UserDefaults
        func test_didFirstPageTriggerFired_whenFetchingIsFalse_andCurrentSortingNotEqualToSelectedSorting_thenFetchCompleted() throws {
            
            //        Given
            sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
            presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
            presenter.setupSorting(.mostPopular)
            presenter.setupState(newState: State(perPage: 5, currentCursor: nil))
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
            XCTAssertEqual(presenter.sorting, .mostPopular)
            XCTAssertEqual(sortingUseCaseProvider.selectedSorting, .createdAt)
            XCTAssertFalse(presenter.isFetching)

            //        When
            
            let expectation = self.expectation(description: #function)
            
            presenter.didFirstPageTriggerFired()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 3)
            
            //        Then
            
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 1)
            XCTAssertEqual(presenter.sorting, .createdAt)
            XCTAssertEqual(sortingUseCaseProvider.selectedSorting, .createdAt)
            XCTAssertFalse(presenter.isFetching)
            
        }
    
    /// Если isFetching установлен в true, запроса первой партии постов не происходит
    func test_didRefreshTriggerFired_whenFetchingIsTrue_thenNoFetch() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostCommented)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
        presenter.setupFetchingStatus(true)
        
        //        When
        
        let expectation = self.expectation(description: #function)
        
        presenter.didRefreshTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
    }
    
    /// Если isFetching установлен в false, первой партии постов происходит в режиме текущей сортировки
        func test_didRefreshTriggerFired_whenFetchingIsFalse_thenFetchCompleted() throws {
            
            //        Given
            sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostPopular)
            presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
            
            presenter.setupSorting(.createdAt)
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 0)
            XCTAssertEqual(presenter.sorting, .createdAt)
            
            //        When
            
            let expectation = self.expectation(description: #function)
            
            presenter.didRefreshTriggerFired()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 3)
            
            //        Then
            XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchFirstPostsMethod, 1)
            XCTAssertEqual(presenter.sorting, .createdAt)
            XCTAssertFalse(presenter.isFetching)
            
        }
    
    /// Если isFetching установлен в true, запроса следующей партии постов не происходит
    func test_didNextPageTriggerFired_whenFetchingIsTrue_thenNoFetch() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostCommented)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 0)
        presenter.setupFetchingStatus(true)
        
        //        When
        
        let expectation = self.expectation(description: #function)
        
        presenter.didNextPageTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 0)
    }
    
    /// Если isFetching установлен в false, но cursor is nil, запроса следующей партии постов не происходит
    func test_didNextPageTriggerFired_whenFetchingIsFalse_andCursorIsNil_thenNoFetch() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostCommented)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 0)
        presenter.setupState(newState: State(perPage: 5, currentCursor: nil))
        
        //        When
        
        let expectation = self.expectation(description: #function)
        
        presenter.didNextPageTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 0)
    }
    
    /// Если isFetching установлен в false и cursor is not nil, происходит запрос следующей партии постов, после чего cursor обновляется новым значением
    func test_didNextPageTriggerFired_whenFetchingIsFalse_andCursorIsNotNil_thenFetchCompleted() throws {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostCommented)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 0)
        let cursorBeforeFetching = "69d5db7e9b0cd1e5fd16881e0ebd02b0JZuSgeb1blHt/k/exRyVZrBJwL6gbt6490WqMsvDAA4q25hBxyMV0RevBovSQi6m"
        presenter.setupState(newState: State(perPage: 5,
                                             currentCursor: cursorBeforeFetching))
        
        //        When
        
        let expectation = self.expectation(description: #function)
        
        presenter.didNextPageTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        
        XCTAssertEqual(postUseCaseProvider.numberOfStartsFetchAfterPostsMethod, 1)
        XCTAssertNotEqual(presenter.state.currentCursor, cursorBeforeFetching)
    }
    
    /// Если вернулась первая партия постов, то posts.count будет равен кол-ву возвращенных постов
    func test_handle_whenFirstPostsFetched_thenPostCountEqualFetchedItemCount() {
        
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .mostPopular)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        
        presenter.setupSorting(.createdAt)
        XCTAssertEqual(presenter.posts.count, 0)
        
        let expectation = self.expectation(description: #function)
        
        presenter.didRefreshTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(presenter.posts.count, 5)
        
        //        When
        
        let expectation2 = self.expectation(description: #function)
        
        presenter.didRefreshTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        //        Then
        XCTAssertEqual(presenter.posts.count, 5)
        
    }
    
    /// Если вернулась следующая партия постов, то кол-во возвращенных постов будет прибавлено к текущему posts.count 
    func test_handle_whenAfterPostsFetched_thenFetchedItemCountAppendingPostCount() {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        presenter.setupSorting(.mostCommented)
        presenter.setupState(newState: State(perPage: 5, currentCursor: nil))

        XCTAssertEqual(presenter.posts.count, 0)
        
        let expectation = self.expectation(description: #function)
        
        presenter.didFirstPageTriggerFired()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(presenter.posts.count, 5)
        let currentCursor = presenter.state.currentCursor
        XCTAssertEqual(currentCursor, "69d5db7e9b0cd1e5fd16881e0ebd02b0JZuSgeb1blHt/k/exRyVZrBJwL6gbt6490WqMsvDAA4q25hBxyMV0RevBovSQi6m")

        //        When

        let expectation2 = self.expectation(description: #function)

        presenter.didNextPageTriggerFired()

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation2.fulfill()
        }

        waitForExpectations(timeout: 3)

        //        Then
        XCTAssertEqual(presenter.posts.count, 6)
        
    }
    
    /// При выборе поста перейти к детальной информации
    func test_didSelectItemTrigger_routingToPostDetailScreen() {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        let router = PostListRouterMock()
        presenter.router = router
        
        let post = Post(id: "1", status: .published, type: .plain, contents: [], createdAt: 1, updatedAt: 1, author: nil, stats: Stats(likes: StatInfo(count: 0), views: StatInfo(count: 0), comments: StatInfo(count: 0), shares: StatInfo(count: 0), replies: StatInfo(count: 0)), isMyFavorite: false)
        let postData = PostData(post)
        XCTAssertEqual(router.numberOfStartToPostDetailScreenMethod, 0)
        
        //        When
        
        let expectation = self.expectation(description: #function)

        presenter.didSelectItemTrigger(postData)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)

        //        Then
        XCTAssertEqual(router.numberOfStartToPostDetailScreenMethod, 1)

        
    }
    
    /// При выборе поста перейти к детальной информации
    func test_presentSortingSettings_routingToSortingScreen() {
        
        //        Given
        sortingUseCaseProvider = SortingUseCaseProviderMock(selectedSorting: .createdAt)
        presenter = PostListPresenter(useCaseProvider: postUseCaseProvider, sortingUseCaseProvider: sortingUseCaseProvider, delegate: nil)
        let router = PostListRouterMock()
        presenter.router = router
        XCTAssertEqual(router.numberOfStartToSortingScreenMethod, 0)
        
        //        When
        
        let expectation = self.expectation(description: #function)

        presenter.presentSortingSettings()

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)

        //        Then
        XCTAssertEqual(router.numberOfStartToSortingScreenMethod, 1)

        
    }
}

extension State: Equatable {
    
    public static func ==(lhs: State, rhs: State) -> Bool {
        return lhs.currentCursor == rhs.currentCursor && lhs.perPage == rhs.perPage
        
    }
    
}
