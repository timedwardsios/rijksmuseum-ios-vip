//
//  PortfolioPresenterTests.swift
//  RijksmuseumTests
//
//  Created by Tim Edwards on 30/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import XCTest
@testable import Rijksmuseum

class PortfolioPresenterTests: XCTestCase {
    class ViewControllerMock: PortfolioViewControllerInterface {
        var viewModel:Portfolio.FetchListings.ViewModel?
        func updateViewModel(viewModel: Portfolio.FetchListings.ViewModel) {
            self.viewModel = viewModel
        }
    }

    var sut: PortfolioPresenter!
    var viewController = ViewControllerMock()
    override func setUp() {
        super.setUp()
        self.sut = PortfolioPresenter()
        sut.viewController = viewController
    }

    func test_presentListings_success(){
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .success([])))
        if case .loaded = viewController.viewModel!.viewState {} else {
            XCTAssert(false)
        }

    }

    func test_presentListings_failure(){
        struct TestError:Error {}
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .failure(TestError())))
        if case .error = viewController.viewModel!.viewState {} else {
            XCTAssert(false)
        }
    }
}
