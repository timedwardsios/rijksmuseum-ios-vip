
import XCTest
@testable import Rijksmuseum

class ArtAPIWorkerTests: XCTestCase {
    // MARK: mocks
    class APIServiceMock: APIServiceInput {
        var performGetRequest_invocations = 0
        var lastRequest:APIRequest?
        var shouldReturnSuccess = true
        var shouldReturnData = true
        func performGet( request: APIRequest,
                         completion: @escaping (Result<Data, Error>) -> Void) {
            performGetRequest_invocations += 1
            lastRequest = request
            let sampleData = Seeds.API.Endpoint.collection.data()
            if shouldReturnSuccess {
                if shouldReturnData {
                } else {
                    completion(.success(Data()))
                }
            } else {
                completion(.failure(Seeds.ErrorSeed()))
            }
            completion(.success(sampleData))
        }
    }

    // MARK: init
    var sut: ArtWorkerAPI!
    var apiService: APIServiceMock!
    override func setUp() {
        super.setUp()
        apiService = APIServiceMock()
        sut = ArtWorkerAPI(apiService: apiService)
    }

    func test_fetchArt(){
        // when
        sut.fetchArt(completion: {_ in})
    }

    func test_fetchArt_apiService_called(){
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(apiService.performGetRequest_invocations == 1,
                  "Should forward to APIService")
    }

    func test_fetchArt_apiService_endpoint(){
        // given
        let correctEndpoint = Seeds.API.Endpoint.collection.rawValue
        // when
        sut.fetchArt(completion: {_ in})
        // then
        XCTAssert(apiService.lastRequest?.endpoint == correctEndpoint,
                  "Should call APIService with correct endpoint")
    }

    func test_fetchArt_apiService_parameters(){
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
        XCTAssert(apiService.lastRequest?.queryItems == queryItems,
                  "Should call APIService with correct parameters")
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
        let exp = XCTestExpectation(description: "Should callback with success")
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
        let remoteId = "RP-T-1904-360"
        let exp = XCTestExpectation(description: "Should callback with result")
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

    func test_fetchArt_callback_apiError(){
        // given
        let exp = XCTestExpectation(description: "Should callback with API error")
        apiService.shouldReturnSuccess = false
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .failure(let error) = result {
                if case ArtWorkerAPI.WorkerError.apiServiceError = error {
                    exp.fulfill()
                }
            }
        })
        wait(for: [exp], timeout: 1)
    }

    func test_fetchArt_callback_jsonError(){
        // given
        let exp = XCTestExpectation(description: "Should callback with JSON error")
        apiService.shouldReturnData = false
        // when
        sut.fetchArt(completion: {result in
            // then
            if case .failure(let error) = result {
                if case ArtWorkerAPI.WorkerError.jsonError = error {
                    exp.fulfill()
                }
            }
        })
        wait(for: [exp], timeout: 1)
    }
}
