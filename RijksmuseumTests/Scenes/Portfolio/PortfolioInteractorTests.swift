//
//  PortfolioInteractorTests.swift
//  RijksmuseumTests
//
//  Created by Tim Edwards on 30/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import XCTest
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
    class PresenterMock: PortfolioPresenterInterface {
        var expectation: XCTestExpectation?
        func didFetchListings(response: Portfolio.FetchListings.Response) {
            expectation?.fulfill()
        }
    }

    class ArtPrimitiveWorkerMock: ArtPrimitiveWorkerInterface {
        func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            completion(.success([]))
        }
    }

    var sut: PortfolioInteractor!
    var presenter = PresenterMock()
    var artPrimitiveWorker = ArtPrimitiveWorkerMock()
    override func setUp() {
        super.setUp()
        self.sut = PortfolioInteractor(presenter: presenter,
                                  artPrimitiveWorker: artPrimitiveWorker)
    }

    func test_fetchListings(){
        let exp = XCTestExpectation()
        presenter.expectation = exp
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        wait(for: [exp], timeout: 3)
    }

    func test_numberOfListings(){
//        let exp = XCTestExpectation()
//        presenter.expectation = exp
//        sut.fetchListings(request: Portfolio.FetchListings.Request())
//        wait(for: [exp], timeout: 3)
    }
}
