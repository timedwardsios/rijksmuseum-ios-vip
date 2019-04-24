
import XCTest
import Service
import Utils
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
    var sut: PortfolioInteractor!
    var outputMock: OutputMock!
    var artServiceMock: ArtServiceMock!
    override func setUp() {
        super.setUp()
        outputMock = OutputMock()
        artServiceMock = ArtServiceMock()
        sut = PortfolioInteractor(output: outputMock,
                                  artService: artServiceMock)
    }
}

extension PortfolioInteractorTests {
    class OutputMock: PortfolioInteractorOutput {
        var presentFetchArt_loadingArgs = 0
        var presentFetchArt_loadedArgs = 0
        var presentFetchArt_loaded_value:[Art]?
        var presentFetchArt_errorArgs = 0
        var presentFetchArt_error_value:Error?
        func presentFetchArt(response: Portfolio.FetchArt.Response) {
            switch response.state {
            case .loading:
                presentFetchArt_loadingArgs += 1
            case .loaded(let arts):
                presentFetchArt_loadedArgs += 1
                presentFetchArt_loaded_value = arts
            case .error(let error):
                presentFetchArt_errorArgs += 1
                presentFetchArt_error_value = error
            }
        }
    }

    class ArtServiceMock: ArtService {
        var active = true
        var artSeed = [Seeds.Model.ArtSeed()]
        var errorSeed = Seeds.ErrorSeed.generic
        var fetchArtArgs = 0
        func fetchArt(completion: @escaping (Result<[Art]>) -> Void) {
            fetchArtArgs += 1
            if active == true {
                completion(.success(artSeed))
            } else {
                completion(.failure(errorSeed))
            }
        }
    }
}

extension PortfolioInteractorTests {
    func test_performFetchArt(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
    }

    func test_performFetchArt_presenter_loading(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loadingArgs == 1)
    }

    func test_performFetchArt_service(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(artServiceMock.fetchArtArgs == 1)
    }

    func test_performFetchArt_presenter_loaded(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loadedArgs == 1)
    }

    func test_performFetchArt_presenter_loaded_value(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loaded_value?.count == 1)
        let value = outputMock.presentFetchArt_loaded_value?.first
        let castValue = value as! Seeds.Model.ArtSeed
        XCTAssert(castValue === artServiceMock.artSeed.first)
    }

    func test_performFetchArt_presenter_error(){
        // given
        let request = Portfolio.FetchArt.Request()
        artServiceMock.active = false
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_errorArgs == 1)
    }

    func test_performFetchArt_presenter_error_value(){
        // given
        let request = Portfolio.FetchArt.Request()
        artServiceMock.active = false
        // when
        sut.performFetchArt(request: request)
        // then
        let value = outputMock.presentFetchArt_error_value as! Seeds.ErrorSeed
        guard case .generic = value else {
            XCTFail()
            return
        }
    }


}
