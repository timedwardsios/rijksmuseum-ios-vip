
import XCTest
import Workers
import Utility
@testable import App

class ArtWorkerNetworkTests: XCTestCase {
    var sut: ArtWorkerNetwork!
    var networkWorkerMock: NetworkWorkerMock!
    override func setUp() {
        super.setUp()
        networkWorkerMock = NetworkWorkerMock()
        sut = ArtWorkerNetwork(networkWorker: networkWorkerMock)
    }
}

extension ArtWorkerNetworkTests {
    class NetworkWorkerMock: NetworkWorkerInput {
        var performGetRequest_invocations = 0
        var lastRequest:NetworkRequest?
        var shouldReturnSuccess = true
        var shouldReturnData = true
        func performGet( request: NetworkRequest,
                         completion: @escaping (Result<Data>) -> Void) {
            performGetRequest_invocations += 1
            lastRequest = request
            let sampleData = Seeds.Network.Endpoint.collection.data()
            if shouldReturnSuccess {
                if shouldReturnData {
                    completion(.success(sampleData))
                } else {
                    completion(.success(Data()))
                }
            } else {
                completion(.failure(Seeds.ErrorSeed()))
            }
        }
    }
}

extension ArtWorkerNetworkTests {
    func test_fetchArt(){
        // when
        sut.fetchArt(completion: {_ in})
    }

    func test_fetchArt_networkWorker_called(){
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(networkWorkerMock.performGetRequest_invocations == 1,
                  "Should forward to NetworkWorker")
    }

    func test_fetchArt_networkWorker_endpoint(){
        // given
        let correctEndpoint = Seeds.Network.Endpoint.collection.rawValue
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(networkWorkerMock.lastRequest?.endpoint == correctEndpoint,
                  "Should call NetworkWorker with correct endpoint")
    }

    func test_fetchArt_networkWorker_parameters(){
        // given
        let queryItems = [URLQueryItem(name: "ps",
                                       value: "100"),
                          URLQueryItem(name: "imgonly",
                                       value: "true"),
                          URLQueryItem(name: "s",
                                       value: "relevance")]
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(networkWorkerMock.lastRequest?.queryItems == queryItems,
                  "Should call NetworkWorker with correct parameters")
    }

    func test_fetchArt_callback(){
        // given
        let exp = XCTestExpectation(description: "Should callback")
        // when
        sut.fetchArt(completion: {_ in
            // then
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }

    func test_fetchArt_callback_success(){
        // given
        let exp = XCTestExpectation(description: "Should succeed")
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .success = result {
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 1)
    }

    func test_fetchArt_callback_arts(){
        // given
        let remoteId = "EFED716C-1180-485A-A511-63F65F1D63F1"
        let exp = XCTestExpectation(description: "Should succeed with result")
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .success(let arts) = result {
                XCTAssert(arts.count == 1)
                XCTAssert(arts.first!.remoteId == remoteId)
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 1)
    }

    func test_fetchArt_callback_failure(){
        // given
        let exp = XCTestExpectation(description: "Should fail when NetworkWorker fails")
        networkWorkerMock.shouldReturnSuccess = false
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .failure(_) = result {
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 1)
    }

    func test_fetchArt_callback_jsonError(){
        // given
        let exp = XCTestExpectation(description: "Should fail when no data")
        networkWorkerMock.shouldReturnData = false
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .failure(_) = result {
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 1)
    }
}
