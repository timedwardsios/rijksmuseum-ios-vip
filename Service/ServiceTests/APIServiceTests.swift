
import XCTest
@testable import Service

class APIClientTests: XCTestCase {

    var sut: APIClientDefault!
    var apiConfig: APIConfigMock!
    var networkService:NetworkServiceMock!

    override func setUp() {
        super.setUp()
        apiConfig = .init()
        networkService = .init()
        networkService.result = .success(Data(count: 10))
        sut = .init(networkService: networkService,
                    apiConfig: apiConfig)
    }
}

extension APIClientTests {

    func test_performRequest_networkService(){
        // given
        let correctUrl = URL(string: "https://hostname.com/path/path?key=value&key=value")
        let request = APIRequestMock()
        // when
        sut.performRequest(request: request) { _ in }
        // then
        XCTAssertEqual(self.networkService.performRequest_invocations.count, 1)
        XCTAssertEqual(self.networkService.performRequest_invocations.last?.0, correctUrl)
        XCTAssertEqual(self.networkService.performRequest_invocations.last?.1, .GET)
    }

    func test_performRequest_callback(){
        // given
        let request = APIRequestMock()
        let exp = XCTestExpectation()
        // when
        sut.performRequest(request: request) { (result) in
            // then
            XCTAssertEqual(self.networkService.result?.unwrap(), result.unwrap())
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performRequest_error(){
        // given
        networkService.result = .failure(Seeds.error)
        let request = APIRequestMock()
        let exp = XCTestExpectation()
        // when
        sut.performRequest(request: request) { (result) in
            // then
            if result.isFailure {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }
}
