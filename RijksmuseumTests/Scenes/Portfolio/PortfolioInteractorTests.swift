
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

    class ArtPrimitiveWorkerMock: ArtPrimitiveWorkerInterface {
        var fetchPrimitives_called = false
        func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            fetchPrimitives_called = true
            completion(.success([SharedMockData.ArtPrimitiveMock()]))
        }
    }

    // MARK: init
    var sut: PortfolioInteractor!
    var presenter: PresenterMock!
    var artPrimitiveWorker: ArtPrimitiveWorkerMock!
    override func setUp() {
        super.setUp()
        presenter = PresenterMock()
        artPrimitiveWorker = ArtPrimitiveWorkerMock()
        sut = PortfolioInteractor(presenter: presenter,
                                  artPrimitiveWorker: artPrimitiveWorker)
    }

    // MARK: tests
    func test_fetchListings_forwarded_presenter(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(presenter.presentListings_called,
                  "Interactor should forward response to presenter")
    }

    func test_fetchListings_forwarded_worker(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(artPrimitiveWorker.fetchPrimitives_called,
                  "Interactor should refer to worker for result")
    }

    func test_numberOfListings_none(){
        // then
        XCTAssert(sut.numberOfListings() == 0,
                  "Before fetching, number of listings should be 0")
    }

    func test_numberOfListings_some(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(sut.numberOfListings() == 1,
                  "After fetching, number of listings should be >0")
    }

    func test_imageUrlForListingAtIndex_none(){
        // then
        XCTAssert(sut.imageUrlForListingAtIndex(0) == nil,
                  "Before fetching, imageUrls should not be available")
    }


    func test_imageUrlForListingAtIndex_some(){
        // given
        let testUrl = SharedMockData.ArtPrimitiveMock().imageUrl
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        // then
        XCTAssert(sut.imageUrlForListingAtIndex(0) == testUrl,
                  "After fetching, imageUrls should be available")
    }

    func test_setHighlightedIndex_none(){
        // when
        sut.setHighlightedIndex(nil)
        // then
        XCTAssert(presenter.presentHighlightedIndex_value == nil,
                  "Removing highlighted index should propagate to presenter")
    }

    func test_setHighlightedIndex_some(){
        // when
        sut.setHighlightedIndex(0)
        // then
        XCTAssert(presenter.presentHighlightedIndex_value == 0,
                  "Setting highlighted index should propagate to presenter")
    }

    func test_setSelectedIndex(){
        // when
        sut.fetchListings(request: Portfolio.FetchListings.Request())
        sut.setSelectedIndex(0)
        // then
        let selectedPrimitiveId = sut.selectedArtPrimitive!.remoteId
        XCTAssert(selectedPrimitiveId == sut.artPrimitives[0].remoteId,
                  "Selected index should set artPrimitive")
    }
}
