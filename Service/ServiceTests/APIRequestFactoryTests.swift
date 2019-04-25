
import XCTest
import TestingUtils
@testable import Service

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!
    var apiConfig: APIConfigMock!
    var apiEndpoint: APIEndpointMock!

    override func setUp() {
        super.setUp()
        apiConfig = APIConfigMock(path: "/" + Seeds.string,
                                  queryItems: [Seeds.urlQueryItem],
                                  scheme: "https",
                                  host: Seeds.string)
        sut = .init(apiConfig: apiConfig)

        apiEndpoint = APIEndpointMock(path: "/" + Seeds.string,
                                      queryItems: [Seeds.urlQueryItem])
    }
}

extension APIRequestFactoryTests {

    func test_createRequest() throws {
        // when
        let request = try sut.createRequest(withEndpoint: apiEndpoint)
        // then
        let actualComponents = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false))
        XCTAssertEqual(apiConfig.scheme, actualComponents.scheme)
        XCTAssertEqual(apiConfig.host, actualComponents.host)
        XCTAssertTrue(actualComponents.path.contains(apiConfig.path))
        let actualQueryItems = try XCTAssertUnwrap(actualComponents.queryItems)
        XCTAssertTrue(Set(apiConfig.queryItems).isSubset(of: actualQueryItems))
        XCTAssertTrue(actualComponents.path.contains(apiEndpoint.path))
        XCTAssertTrue(Set(apiEndpoint.queryItems).isSubset(of: actualQueryItems))
    }

    func test_createRequest_noConfigScheme() {
        // given
        apiConfig.scheme = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(withEndpoint: apiEndpoint))
    }

    func test_createRequest_noConfigHostname() {
        // given
        apiConfig.host = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(withEndpoint: apiEndpoint))
    }

    func test_createRequest_noConfigPath() throws {
        // given
        apiConfig.path = ""
        // then
        let request = try XCTAssertUnwrap(sut.createRequest(withEndpoint: apiEndpoint))
        XCTAssertEqual(apiEndpoint.path, request.url.path)
    }

    func test_createRequest_noConfigQueryItems() throws {
        // given
        apiConfig.queryItems = [URLQueryItem]()
        // then
        let request = try XCTAssertUnwrap(sut.createRequest(withEndpoint: apiEndpoint))
        let actualQueryItems = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiEndpoint.queryItems), Set(actualQueryItems))
    }

    func test_createRequest_noEndpointPath() throws {
        // given
        apiEndpoint.path = ""
        // then
        XCTAssertThrowsError(try sut.createRequest(withEndpoint: apiEndpoint))
    }

    func test_createRequest_noEndpointQueryItems() throws {
        apiEndpoint.queryItems = [URLQueryItem]()
        let request = try XCTAssertUnwrap(sut.createRequest(withEndpoint: apiEndpoint))
        let actualQueryItems = try XCTAssertUnwrap(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiConfig.queryItems), Set(actualQueryItems))
    }
}
