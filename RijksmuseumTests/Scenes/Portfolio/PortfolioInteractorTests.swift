
import XCTest
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
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
}

extension PortfolioInteractorTests {
    class PresenterMock: PortfolioPresenterInterface {
        var presentFetchListings_loading_invocations = 0
        var presentFetchListings_loaded_invocations = 0
        var presentFetchListings_loaded_value:[ArtPrimitive]?
        var presentFetchListings_error_invocations = 0
        var presentFetchListings_error_value:Error?
        func presentFetchListings(response: Portfolio.FetchListings.Response) {
            switch response.state {
            case .loading:
                presentFetchListings_loading_invocations += 1
            case .loaded(let artPrimitives):
                presentFetchListings_loaded_invocations += 1
                presentFetchListings_loaded_value = artPrimitives
            case .error(let error):
                presentFetchListings_error_invocations += 1
                presentFetchListings_error_value = error
            }
        }

        var presentHighlightedIndex_value:Int?
        func presentHighlightedIndex(_ index: Int?) {
            presentHighlightedIndex_value = index
        }
    }

    class ArtPrimitiveWorkerMock: ArtPrimitiveWorker {
        var active = true
        var artPrimitiveSeed = [Seeds.Model.ArtPrimitiveSeed()]
        var errorSeed = Seeds.ErrorSeed()
        var fetchPrimitives_invocations = 0
        func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            fetchPrimitives_invocations += 1
            if active == true {
                completion(.success(artPrimitiveSeed))
            } else {
                completion(.failure(errorSeed))
            }
        }
    }
}

extension PortfolioInteractorTests {
    func test_performFetchListings(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
    }

    func test_performFetchListings_presenter_loading(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(presenter.presentFetchListings_loading_invocations == 1)
    }

    func test_performFetchListings_worker(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(artPrimitiveWorker.fetchPrimitives_invocations == 1)
    }

    func test_performFetchListings_presenter_loaded(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(presenter.presentFetchListings_loaded_invocations == 1)
    }

    func test_performFetchListings_presenter_loaded_value(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        let value = presenter.presentFetchListings_loaded_value?.first
        let castValue = value as! Seeds.Model.ArtPrimitiveSeed
        XCTAssert(castValue === artPrimitiveWorker.artPrimitiveSeed.first)
    }

    func test_performFetchListings_presenter_error(){
        // given
        let request = Portfolio.FetchListings.Request()
        artPrimitiveWorker.active = false
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(presenter.presentFetchListings_error_invocations == 1)
    }

    func test_performFetchListings_presenter_error_value(){
        // given
        let request = Portfolio.FetchListings.Request()
        artPrimitiveWorker.active = false
        // when
        sut.performFetchListings(request: request)
        // then
        let value = presenter.presentFetchListings_error_value as! Seeds.ErrorSeed
        XCTAssert(value === artPrimitiveWorker.errorSeed)
    }
}
