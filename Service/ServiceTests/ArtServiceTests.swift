
import XCTest
import Utils
import TestingUtils
@testable import Service

class ArtServiceTests: XCTestCase {

    var sut: ArtServiceDefault!
    var networkRequest: NetworkRequestMock!
    var apiRequestFactory: APIRequestFactorySpy!
    var networkService: NetworkServiceSpy!

    override func setUp() {
        super.setUp()
        networkRequest = .init(url: Seeds.url,
                               method: .GET)
        apiRequestFactory = .init(createRequestResult: .success(networkRequest))
        networkService = .init(processRequestResult: .success(Seeds.data))
        sut = .init(apiRequestFactory: apiRequestFactory,
                    networkService: networkService)
    }
}

extension ArtServiceTests {

    func test_fetchArt_callback() {
//        let exp = XCTestExpectation()
//        sut.fetchArt { (result) in
//            if let arts = result.unwrap() {
//                
//                exp.fulfill()
//            }
//        }
//        wait(exp)
    }

    func test_fetchArt_apiRequestFactory() {
        let exp = XCTestExpectation()
        sut.fetchArt { (_) in
            XCTAssertEqual(self.apiRequestFactory.createRequestArgs.count, 1)
            XCTAssertEqual(self.apiRequestFactory.createRequestArgs.first?.path, "/collection")
            exp.fulfill()
        }
        wait(exp)
    }

    func test_fetchArt_networkService() {
        let exp = XCTestExpectation()
        sut.fetchArt { (_) in
            XCTAssertEqual(self.networkService.performRequestArgs.count, 1)
            XCTAssertEqual(self.networkService.performRequestArgs.first?.url, self.networkRequest.url)
            exp.fulfill()
        }
        wait(exp)
    }

//    func test_fetchArt(){
//        // when
//        sut.fetchArt(completion: {_ in})
//    }
//
//    func test_fetchArt_apiRequestFactoryMock_called(){
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiRequestFactoryMock.performGetRequestArgs == 1,
//                  "Should forward to APIRequestFactory")
//    }
//
//    func test_fetchArt_apiRequestFactoryMock_endpoint(){
//        // given
//        let correctEndpoint = ModelMock.Network.Endpoint.collection.rawValue
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiRequestFactoryMock.lastRequest?.path == correctEndpoint,
//                  "Should call APIRequestFactory with correct endpoint")
//    }
//
//    func test_fetchArt_apiRequestFactoryMock_parameters(){
//        // given
//        let queryItems = [URLQueryItem(name: "ps",
//                                       value: "100"),
//                          URLQueryItem(name: "imgonly",
//                                       value: "true"),
//                          URLQueryItem(name: "s",
//                                       value: "relevance")]
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiRequestFactoryMock.lastRequest?.queryItems == queryItems,
//                  "Should call APIRequestFactory with correct parameters")
//    }
//
//    func test_fetchArt_callback(){
//        // given
//        let exp = XCTestExpectation(description: "Should callback")
//        // when
//        sut.fetchArt(completion: {_ in
//            // then
//            exp.fulfill()
//        })
//        wait()
//    }
//
//    func test_fetchArt_callback_success(){
//        // given
//        let exp = XCTestExpectation(description: "Should succeed")
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .success = result {
//                exp.fulfill()
//            }
//        })
//        wait()
//    }
//
//    func test_fetchArt_callback_arts(){
//        // given
//        let id = "EFED716C-1180-485A-A511-63F65F1D63F1"
//        let exp = XCTestExpectation(description: "Should succeed with result")
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .success(let arts) = result {
//                XCTAssert(arts.count == 1)
//                XCTAssert(arts.first!.id == id)
//                exp.fulfill()
//            }
//        })
//        wait()
//    }
//
//    func test_fetchArt_callback_failure(){
//        // given
//        let exp = XCTestExpectation(description: "Should fail when APIRequestFactory fails")
//        apiRequestFactoryMock.shouldReturnSuccess = false
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .failure(_) = result {
//                exp.fulfill()
//            }
//        })
//        wait()
//    }
//
//    func test_fetchArt_callback_jsonError(){
//        // given
//        let exp = XCTestExpectation(description: "Should fail when no data")
//        apiRequestFactoryMock.shouldReturnData = false
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .failure(_) = result {
//                exp.fulfill()
//            }
//        })
//        wait()
//    }
}
