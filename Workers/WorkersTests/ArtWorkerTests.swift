
import XCTest
import Workers
import Utilities
@testable import App

class ArtWorkerAPITests: XCTestCase {
    var sut: ArtWorkerAPI!
    var apiWorkerMock: APIWorkerMock!
    override func setUp() {
        super.setUp()
        apiWorkerMock = APIWorkerMock()
        sut = ArtWorkerAPI(apiWorker: apiWorkerMock)
    }
}

extension ArtWorkerAPITests {
    class APIWorkerMock: APIWorkerInput {
        var performGetRequest_invocations = 0
        var lastRequest:APIRequest?
        var shouldReturnSuccess = true
        var shouldReturnData = true
        func performGet( request: APIRequest,
                         completion: @escaping (Result<Data>) -> Void) {
            performGetRequest_invocations += 1
            lastRequest = request
            let sampleData = Seeds.API.Endpoint.collection.data()
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

extension ArtWorkerAPITests {
    func test_fetchArt(){
        // when
        sut.fetchArt(completion: {_ in})
    }

    func test_fetchArt_apiWorker_called(){
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(apiWorkerMock.performGetRequest_invocations == 1,
                  "Should forward to APIWorker")
    }

    func test_fetchArt_apiWorker_endpoint(){
        // given
        let correctEndpoint = Seeds.API.Endpoint.collection.rawValue
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(apiWorkerMock.lastRequest?.endpoint == correctEndpoint,
                  "Should call APIWorker with correct endpoint")
    }

    func test_fetchArt_apiWorker_parameters(){
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
        XCTAssert(apiWorkerMock.lastRequest?.queryItems == queryItems,
                  "Should call APIWorker with correct parameters")
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
        let exp = XCTestExpectation(description: "Should fail when APIWorker fails")
        apiWorkerMock.shouldReturnSuccess = false
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
        apiWorkerMock.shouldReturnData = false
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
