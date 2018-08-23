
import XCTest
@testable import App

class ArtWorkerNetworkTests: XCTestCase {
    var sut: ArtWorkerNetwork!
    var networkServiceMock: NetworkServiceMock!
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        sut = ArtWorkerNetwork(networkService: networkServiceMock)
    }
}

extension ArtWorkerNetworkTests {
    class NetworkServiceMock: NetworkServiceInput {
        var performGetRequest_invocations = 0
        var lastRequest:NetworkRequest?
        var shouldReturnSuccess = true
        var shouldReturnData = true
        func performGet( request: NetworkRequest,
                         completion: @escaping (NetworkServiceResult) -> Void) {
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

    func test_fetchArt_networkService_called(){
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(networkServiceMock.performGetRequest_invocations == 1,
                  "Should forward to NetworkService")
    }

    func test_fetchArt_networkService_endpoint(){
        // given
        let correctEndpoint = Seeds.Network.Endpoint.collection.rawValue
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(networkServiceMock.lastRequest?.endpoint == correctEndpoint,
                  "Should call NetworkService with correct endpoint")
    }

    func test_fetchArt_networkService_parameters(){
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
        XCTAssert(networkServiceMock.lastRequest?.queryItems == queryItems,
                  "Should call NetworkService with correct parameters")
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
        let exp = XCTestExpectation(description: "Should fail when NetworkService fails")
        networkServiceMock.shouldReturnSuccess = false
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
        networkServiceMock.shouldReturnData = false
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
