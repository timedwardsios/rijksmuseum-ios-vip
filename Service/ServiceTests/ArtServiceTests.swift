
import XCTest
import TestUtils
@testable import Service

class ArtServiceNetworkTests: XCTestCase {

    var sut: ArtServiceDefault!
    var apiRequestFactoryMock: APIRequestFactoryMock!
    var networkService: NetworkServiceMock!

    override func setUp() {
        super.setUp()
//        apiRequestFactoryMock = .init(createRequestReturnValue: network)
//        sut = .init(apiRequestFactory: apiRequestFactoryMock)
    }
}

extension ArtServiceNetworkTests {

    func test_fetchArt(){
        // given

        // when
//        sut.fetchArt { (_) in}
        // then
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
