
import XCTest
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
    var sut: PortfolioInteractor!
    var presenterMock: PresenterMock!
    var artWorkerMock: ArtWorkerMock!
    override func setUp() {
        super.setUp()
        presenterMock = PresenterMock()
        artWorkerMock = ArtWorkerMock()
        sut = PortfolioInteractor(presenter: presenterMock,
                                  artWorker: artWorkerMock)
    }
}

extension PortfolioInteractorTests {
    class PresenterMock: PortfolioPresenterInput {
        var presentFetchListings_loading_invocations = 0
        var presentFetchListings_loaded_invocations = 0
        var presentFetchListings_loaded_value:[Art]?
        var presentFetchListings_error_invocations = 0
        var presentFetchListings_error_value:Error?
        func presentFetchListings(response: Portfolio.FetchListings.Response) {
            switch response.state {
            case .loading:
                presentFetchListings_loading_invocations += 1
            case .loaded(let arts):
                presentFetchListings_loaded_invocations += 1
                presentFetchListings_loaded_value = arts
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

    class ArtWorkerMock: ArtWorkerInput {
        var active = true
        var artSeed = [Seeds.Model.ArtSeed()]
        var errorSeed = Seeds.ErrorSeed()
        var fetchArt_invocations = 0
        func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {
            fetchArt_invocations += 1
            if active == true {
                completion(.success(artSeed))
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
        XCTAssert(presenterMock.presentFetchListings_loading_invocations == 1)
    }

    func test_performFetchListings_worker(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(artWorkerMock.fetchArt_invocations == 1)
    }

    func test_performFetchListings_presenter_loaded(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(presenterMock.presentFetchListings_loaded_invocations == 1)
    }

    func test_performFetchListings_presenter_loaded_value(){
        // given
        let request = Portfolio.FetchListings.Request()
        // when
        sut.performFetchListings(request: request)
        // then
        let value = presenterMock.presentFetchListings_loaded_value?.first
        let castValue = value as! Seeds.Model.ArtSeed
        XCTAssert(castValue === artWorkerMock.artSeed.first)
    }

    func test_performFetchListings_presenter_error(){
        // given
        let request = Portfolio.FetchListings.Request()
        artWorkerMock.active = false
        // when
        sut.performFetchListings(request: request)
        // then
        XCTAssert(presenterMock.presentFetchListings_error_invocations == 1)
    }

    func test_performFetchListings_presenter_error_value(){
        // given
        let request = Portfolio.FetchListings.Request()
        artWorkerMock.active = false
        // when
        sut.performFetchListings(request: request)
        // then
        let value = presenterMock.presentFetchListings_error_value as! Seeds.ErrorSeed
        XCTAssert(value === artWorkerMock.errorSeed)
    }
}
