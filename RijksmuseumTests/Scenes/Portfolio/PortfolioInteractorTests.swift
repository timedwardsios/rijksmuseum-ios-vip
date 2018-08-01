
import XCTest
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
    // MARK: mocks
    class PresenterMock: PortfolioPresenterInterface {
        var presentListings_called = false
        func presentListings(response: Portfolio.FetchListings.Response) {
            presentListings_called = true
        }

        var presentHighlightedIndex_value:Int?
        func presentHighlightedIndex(_ index: Int?) {
            presentHighlightedIndex_value = index
        }
    }

    class ArtPrimitiveWorkerMock: ArtPrimitiveWorker {
        var fetchPrimitives_called = false
        override func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            fetchPrimitives_called = true
            completion(.success([TestData.ArtPrimitiveMock()]))
        }
    }

    // MARK: init
    var sut: PortfolioInteractor!
    var presenter: PresenterMock!
    var artPrimitiveWorker: ArtPrimitiveWorkerMock!
    override func setUp() {
        super.setUp()
        presenter = PresenterMock()
        artPrimitiveWorker = ArtPrimitiveWorkerMock(artPrimitiveSource: ArtPrimitiveAPIService())
        sut = PortfolioInteractor(presenter: presenter,
                                  artPrimitiveWorker: artPrimitiveWorker)
    }

    // MARK: tests
    func test_fetchListings_presenter_called(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(presenter.presentListings_called)
    }

    func test_fetchListings_worker_called(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(artPrimitiveWorker.fetchPrimitives_called)
    }

    func test_numberOfListings(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(sut.numberOfListings() == 1)
    }

    func test_imageUrlForListingAtIndex(){
        // given
        let testUrl = TestData.ArtPrimitiveMock().imageUrl
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(sut.imageUrlForListingAtIndex(0) == testUrl)
    }

    func test_imageUrlForListingAtIndex_outOfRange(){
        // then
        XCTAssert(sut.imageUrlForListingAtIndex(0) == nil)
    }

    func test_setHighlightedIndex_none(){
        // when
        sut.setHighlightedIndex(nil)
        // then
        XCTAssert(presenter.presentHighlightedIndex_value == nil)
    }

    func test_setHighlightedIndex_some(){
        // when
        sut.setHighlightedIndex(0)
        // then
        XCTAssert(presenter.presentHighlightedIndex_value == 0)
    }

    func test_setSelectedIndex(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        sut.setSelectedIndex(0)
        // then
        let selectedPrimitiveId = sut.selectedArtPrimitive!.remoteId
        XCTAssert(selectedPrimitiveId == sut.artPrimitives[0].remoteId)
    }
}
