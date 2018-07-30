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
        var didFetchListings_called = false
        func didFetchListings(response: Portfolio.FetchListings.Response) {
            didFetchListings_called = true
        }
    }

    class ArtPrimitiveWorkerMock: ArtPrimitiveWorkerInterface {
        var fetchPrimitives_called = false
        func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            fetchPrimitives_called = true
            struct Art:ArtPrimitive{
                var remoteId = "remoteId"
                var title = "title"
                var artist = "artist"
                var imageUrl = URL(string: "http://www.apple.com")!
            }
            var arts = Array.init(repeating: Art(), count: 10)
            arts[0].remoteId = "123456789"
            arts[0].imageUrl = URL(string: "http://www.google.com")!
            completion(.success(arts))
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
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        XCTAssert(presenter.didFetchListings_called)
        XCTAssert(artPrimitiveWorker.fetchPrimitives_called)
    }

    func test_numberOfListings_none(){
        XCTAssert(sut.numberOfListings() == 0)
    }

    func test_numberOfListings_some(){
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        XCTAssert(sut.numberOfListings() == 10)
    }

    func test_imageUrlForListingAtIndex_none(){
        XCTAssert(sut.imageUrlForListingAtIndex(0) == nil)
    }

    func test_imageUrlForListingAtIndex_some(){
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        XCTAssert(sut.imageUrlForListingAtIndex(0) == URL(string: "http://www.google.com"))
    }

    func test_setSelectedRow_none(){
        sut.setSelectedRow(0)
        XCTAssert(sut.selectedArtPrimitive == nil)
    }

    func test_setSelectedRow_some(){
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        sut.setSelectedRow(0)
        XCTAssert(sut.selectedArtPrimitive!.remoteId == sut.artPrimitives[0].remoteId)
    }
}
