
import XCTest
import TestingUtils
@testable import Services

class NetworkRequestFactoryTests: XCTestCase {

    var sut: NetworkRequestFactoryDefault!
    var apiConfig: APIConfigMock!
    var apiRequest: APIRequestMock!

    override func setUp() {
        super.setUp()
        apiConfig = APIConfigMock(path: "/" + Seeds.string,
                                  queryItems: [Seeds.urlQueryItem],
                                  scheme: "https",
                                  host: Seeds.string)
        sut = .init(apiConfig: apiConfig)

        apiRequest = APIRequestMock(path: "/" + Seeds.string,
                                      queryItems: [Seeds.urlQueryItem])
    }
}

extension NetworkRequestFactoryTests {

    func test_createRequest() throws {
        // when
        let request = try sut.createRequest(fromAPIRequest: apiRequest)
        // then
        let actualComponents = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false))
        XCTAssertEqual(apiConfig.scheme, actualComponents.scheme)
        XCTAssertEqual(apiConfig.host, actualComponents.host)
        XCTAssertTrue(actualComponents.path.contains(apiConfig.path))
        let actualQueryItems = try XCTAssertUnwrap(actualComponents.queryItems)
        XCTAssertTrue(Set(apiConfig.queryItems).isSubset(of: actualQueryItems))
        XCTAssertTrue(actualComponents.path.contains(apiRequest.path))
        XCTAssertTrue(Set(apiRequest.queryItems).isSubset(of: actualQueryItems))
    }

    func test_createRequest_noConfigScheme() {
        // given
        apiConfig.scheme = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noConfigHostname() {
        // given
        apiConfig.host = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noConfigPath() throws {
        // given
        apiConfig.path = ""
        // then
        let request = try XCTAssertUnwrap(sut.createRequest(fromAPIRequest: apiRequest))
        XCTAssertEqual(apiRequest.path, request.url.path)
    }

    func test_createRequest_noConfigQueryItems() throws {
        // given
        apiConfig.queryItems = [URLQueryItem]()
        // then
        let request = try XCTAssertUnwrap(sut.createRequest(fromAPIRequest: apiRequest))
        let actualQueryItems = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiRequest.queryItems), Set(actualQueryItems))
    }

    func test_createRequest_noRequestPath() throws {
        // given
        apiRequest.path = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noRequestQueryItems() throws {
        apiRequest.queryItems = [URLQueryItem]()
        let request = try XCTAssertUnwrap(sut.createRequest(fromAPIRequest: apiRequest))
        let actualQueryItems = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiConfig.queryItems), Set(actualQueryItems))
    }
}
