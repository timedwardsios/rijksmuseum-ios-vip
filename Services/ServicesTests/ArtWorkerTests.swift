
import XCTest
import UtilsTestTools
@testable import Services

class ArtWorkerTests: XCTestCase {

    var sut: ArtWorkerDefault!

    var apiRequestFactory: APIRequestFactorySpy!
    var networkRequestFactory: NetworkRequestFactorySpy!
    var networkService: NetworkServiceSpy!
    var artFactory: ArtFactorySpy!

    var apiRequest: APIRequestMock!
    var networkRequest: NetworkRequestMock!
    var art: ArtMock!

    override func setUp() {
        super.setUp()

        apiRequest = .init()
        networkRequest = .init()
        art = .init()

        apiRequestFactory = .init(createRequestResult: apiRequest)
        networkRequestFactory = .init(createRequestResult: .success(networkRequest))
        networkService = .init(processRequestResult: .success(Seeds.data))
        artFactory = .init(createArtsResult: .success([art]))
        sut = .init(apiRequestFactory: apiRequestFactory,
                    networkRequestFactory: networkRequestFactory,
                    networkService: networkService,
                    artFactory: artFactory)
    }
}

extension ArtWorkerTests {
    func test_fetchArt(){
        let exp = XCTestExpectation()
        sut.fetchArt { (result) in
            XCTAssertEqual(self.art.id, result.unwrap()?.first?.id)
            XCTAssertEqual(APIEndpoint.art, self.apiRequestFactory.createRequestArgs.last)
            XCTAssertEqual(self.apiRequest.path, self.networkRequestFactory.createRequestArgs.last?.path)
            XCTAssertEqual(self.networkRequest.url, self.networkService.processRequestArgs.last?.url)
            XCTAssertEqual(self.networkService.processRequestResult.unwrap(), self.artFactory.createArtsArgs.last)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_fetchArt_networkRequestError(){
        let exp = XCTestExpectation()
        networkRequestFactory.createRequestResult = .failure(Seeds.error)
        sut.fetchArt { (result) in
            XCTAssertTrue(result.isFailure)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_fetchArt_networkServiceError(){
        let exp = XCTestExpectation()
        networkService.processRequestResult = .failure(Seeds.error)
        sut.fetchArt { (result) in
            XCTAssertTrue(result.isFailure)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_fetchArt_artFactoryError(){
        let exp = XCTestExpectation()
        artFactory.createArtsResult = .failure(Seeds.error)
        sut.fetchArt { (result) in
            XCTAssertTrue(result.isFailure)
            exp.fulfill()
        }
        wait(exp)
    }
}
