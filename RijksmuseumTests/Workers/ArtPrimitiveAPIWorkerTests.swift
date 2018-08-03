
import XCTest
@testable import Rijksmuseum

class ArtPrimitiveAPIWorkerTests: XCTestCase {
    // MARK: mocks
    class NetworkClientMock: NetworkClient {
        var dataTask_called = false
        var lastUrl:URL? = nil
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            dataTask_called = true
            return URLSessionDataTask()
        }
    }

    // MARK: init
    var sut: ArtPrimitiveAPIWorker!
    var networkClient: NetworkClientMock!
    override func setUp() {
        super.setUp()
        networkClient = NetworkClientMock()
        sut = ArtPrimitiveAPIWorker(networkClient: networkClient)
    }

    func test_fetchPrimitives(){
        sut.fetchPrimitives(completion: {_ in})
    }

    func test_fetchPrimitives_calls_networkClient(){
        sut.fetchPrimitives(completion: {_ in})
        XCTAssert(networkClient.dataTask_called)
    }

    func test_fetchPrimitives_calls_networkClient_correctUrl(){
        sut.fetchPrimitives(completion: {_ in})
        XCTAssert(<#T##expression: Bool##Bool#>)
    }

//    func test_fetchPrimitives_

    // MARK: tests
//    func test_fetchPrimitives_forwarded_service(){
//        sut.fetchPrimitives {_ in}
//        XCTAssert(artPrimitiveService.loadPrimitives_called,
//                  "Method should be forwarded to the service object")
//    }
//
//    func test_fetchPrimitives_return_success(){
//        // given
//        let exp = XCTestExpectation(description: "Should return success")
//        // when
//        sut.fetchPrimitives { (result) in
//            // then
//            guard case .success = result else {
//                XCTFail("Didn't return success")
//                return
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_fetchPrimitives_return_failure(){
//        // given
//        let exp = XCTestExpectation(description: "Should return failure")
//        artPrimitiveService.active = false
//        // when
//        sut.fetchPrimitives { (result) in
//            // then
//            guard case .failure = result else {
//                XCTFail("Didn't return failure")
//                return
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 1)
//    }
}
