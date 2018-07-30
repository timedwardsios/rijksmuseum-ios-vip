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
    struct PresenterMock: PortfolioPresenterInput {
        let exp = XCTestExpectation()
        func didFetchListings(response: Portfolio.FetchListings.Response) {
            exp.fulfill()
        }
    }

    override func setUp() {
        super.setUp()

    }

    func test_fetchListings(){
        let presenter = PresenterMock()
        let interactor = PortfolioInteractor(presenter: presenter, artPrimitiveWorker: <#T##ArtPrimitiveWorker#>)
        interactor.fetchListings(request: Portfolio.FetchListings.Request())
        wait(for: [presenter.exp], timeout: 3)
    }

    func test_numberOfListings(){
        let presenter = PresenterMock()
        let interactor = PortfolioInteractor(presenter: presenter)
        interactor.numberOfListings()
        wait(for: [presenter.exp], timeout: 3)
    }
}
