
import XCTest
import TestTools
@testable import Kit

class NetworkRequestFactoryTests: XCTestCase {

    var sut: NetworkRequestFactoryDefault!

    var apiConfigMock: APIConfigMock!
    var apiRequest: APIRequestMock!

    override func setUp() {
        super.setUp()
        apiConfigMock = .init()
        sut = .init(apiConfig: apiConfigMock)
        apiRequest = .init()
    }
}

extension NetworkRequestFactoryTests {

    func test_createRequest() throws {
        // when
        let request = try sut.networkRequest(fromAPIRequest: apiRequest)
        // then
        let actualComponents = try XCTAssertUnwrapOptional(URLComponents(url: request.url, resolvingAgainstBaseURL: false))
        XCTAssertEqual(apiConfigMock.scheme, actualComponents.scheme)
        XCTAssertEqual(apiConfigMock.host, actualComponents.host)
        XCTAssertTrue(actualComponents.path.contains(apiConfigMock.path))
        let actualQueryItems = try XCTAssertUnwrapOptional(actualComponents.queryItems)
        XCTAssertTrue(Set(apiConfigMock.queryItems).isSubset(of: actualQueryItems))
        XCTAssertTrue(actualComponents.path.contains(apiRequest.path))
        XCTAssertTrue(Set(apiRequest.queryItems).isSubset(of: actualQueryItems))
    }

    func test_createRequest_noConfigScheme() {
        // given
        apiConfigMock.scheme = ""
        sut = .init(apiConfig: apiConfigMock)
        // then
        XCTAssertThrowsError(try sut.networkRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noConfigHostname() {
        // given
        apiConfigMock.host = ""
        sut = .init(apiConfig: apiConfigMock)
        // then
        XCTAssertThrowsError(try sut.networkRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noConfigPath() throws {
        // given
        apiConfigMock.path = ""
        sut = .init(apiConfig: apiConfigMock)
        // then
        let request = try XCTAssertUnwrapOptional(sut.networkRequest(fromAPIRequest: apiRequest))
        XCTAssertEqual(apiRequest.path, request.url.path)
    }

    func test_createRequest_noConfigQueryItems() throws {
        // given
        apiConfigMock.queryItems = [URLQueryItem]()
        sut = .init(apiConfig: apiConfigMock)
        // then
        let request = try XCTAssertUnwrapOptional(sut.networkRequest(fromAPIRequest: apiRequest))
        let actualQueryItems = try XCTAssertUnwrapOptional(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiRequest.queryItems), Set(actualQueryItems))
    }

    func test_createRequest_noRequestPath() throws {
        // given
        apiRequest.path = ""
        // then
        XCTAssertThrowsError(try sut.networkRequest(fromAPIRequest: apiRequest))
    }

    func test_createRequest_noRequestQueryItems() throws {
        apiRequest.queryItems = [URLQueryItem]()
        let request = try XCTAssertUnwrapOptional(sut.networkRequest(fromAPIRequest: apiRequest))
        let actualQueryItems = try XCTAssertUnwrapOptional(URLComponents(url: request.url, resolvingAgainstBaseURL: false)?.queryItems)
        XCTAssertEqual(Set(apiConfigMock.queryItems), Set(actualQueryItems))
    }
}
