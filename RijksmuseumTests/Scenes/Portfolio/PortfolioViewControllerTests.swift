//
//  PortfolioViewControllerTests.swift
//  RijksmuseumTests
//
//  Created by Tim Edwards on 30/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import XCTest
@testable import Rijksmuseum

class PortfolioViewControllerTests: XCTestCase {
    class InteractorMock: PortfolioInteractorInterface {
        func fetchListings(request: Portfolio.FetchListings.Request) {
            //
        }

        func numberOfListings() -> Int {
            //
        }

        func imageUrlForListingAtIndex(_ index: Int) -> URL? {
            //
        }

        func setSelectedRow(_ row: Int) {
            //
        }
    }

    class RouterMock: PortfolioRouterInterface {
        var dataStore: PortfolioDataStore?
    }

    var sut: PortfolioViewController!
    var interactor = InteractorMock()
    var router = RouterMock()
    override func setUp() {
        super.setUp()
        self.router = RouterMock(dataStore: Interactor)
        self.router = RouterMock(dataStore: )
        self.sut = PortfolioViewController(interactor: interactor,
                                           router: RouterMock)
    }

    func test_presentListings_success(){
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .success([])))
        if case .loaded = interactor.viewModel!.viewState {} else {
            XCTAssert(false)
        }

    }

    func test_presentListings_failure(){
        struct TestError:Error {}
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .failure(TestError())))
        if case .error = interactor.viewModel!.viewState {} else {
            XCTAssert(false)
        }
    }
}
