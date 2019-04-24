
import XCTest
@testable import Service
import Utils

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!
    var apiConfig: APIConfig!
    var apiEndpoint: APIEndpoint!

    override func setUp() {
        super.setUp()
        apiConfig = Seeds.apiConfig
        sut = .init(apiConfig: apiConfig)
        apiEndpoint = Seeds.apiEndpoint
    }
}

extension APIRequestFactoryTests {

    func test_createRequest_apiConfig() throws {
        let request = try sut.createRequest(withEndpoint: apiEndpoint)
        let actualComponents = try XCTAssertUnwrap(URLComponents(url: request.url,
                                                               resolvingAgainstBaseURL: false))
        XCTAssertEqual(apiConfig.scheme, actualComponents.scheme)
        XCTAssertEqual(apiConfig.hostname, actualComponents.host)
        XCTAssertTrue(actualComponents.path.contains(apiConfig.path))
        let actualQueryItems = try XCTAssertUnwrap(actualComponents.queryItems)
        XCTAssertTrue(Set(apiConfig.queryItems).isSubset(of: actualQueryItems))
    }

    func test_createRequest_endpoint() throws {
        let request = try sut.createRequest(withEndpoint: apiEndpoint)
        let actualComponents = try XCTAssertUnwrap(URLComponents(url: request.url,
                                                                 resolvingAgainstBaseURL: false))
        XCTAssertTrue(actualComponents.path.contains(apiEndpoint.path))
        let actualQueryItems = try XCTAssertUnwrap(actualComponents.queryItems)
        XCTAssertTrue(Set(apiConfig.queryItems).isSubset(of: actualQueryItems))
    }

//    func test_createRequest_endpoint() throws {
//        let request = try sut.createRequest(withEndpoint: .art)
//        let actualComponents = try XCTAssertUnwrap(URLComponents(url: request.url,
//                                                                 resolvingAgainstBaseURL: false))
//
//        XCTAssertEqual(apiConfig.path, actualComponents.path)
//        XCTAssertEqual(apiConfig.path, actualComponents.path)
//        let actualQueryItems = try XCTAssertUnwrap(actualComponents.queryItems)
//        XCTAssertEqual(Set(apiConfig.queryItems), Set(actualQueryItems))
//    }


//    func test_performRequest_networkService(){
//        // given
//        let correctUrl = URL(string: "https://hostname.com/path/path?key=value&key=value")
//        let request = APIRequestMock()
//        // when
//        sut.performRequest(request: request) { _ in }
//        // then
//        XCTAssertEqual(self.networkService.performRequestArgs.count, 1)
//        XCTAssertEqual(self.networkService.performRequestArgs.last?.0, correctUrl)
//        XCTAssertEqual(self.networkService.performRequestArgs.last?.1, .GET)
//    }
//
//    func test_performRequest_callback(){
//        // given
//        let request = APIRequestMock()
//        let exp = XCTestExpectation()
//        // when
//        sut.performRequest(request: request) { (result) in
//            // then
//            XCTAssertEqual(self.networkService.result?.unwrap(), result.unwrap())
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_performRequest_error(){
//        // given
//        networkService.result = .failure(Seeds.error)
//        let request = APIRequestMock()
//        let exp = XCTestExpectation()
//        // when
//        sut.performRequest(request: request) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
}
