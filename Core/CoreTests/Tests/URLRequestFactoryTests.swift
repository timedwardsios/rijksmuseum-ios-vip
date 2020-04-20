@testable import MuseumCore
import TestKit
import Utils
import XCTest

class URLRequestFactoryTests: XCTestCase {
    var sut: URLRequestFactoryDefault!

    var apiBaseConfigMock: APIBaseConfigMock!

    var apiRequestMock: APIRequestMock!

    override func setUp() {
        super.setUp()

        apiRequestMock = APIRequestMock()

        apiBaseConfigMock = APIBaseConfigMock()

        sut = URLRequestFactoryDefault(baseAPIConfig: apiBaseConfigMock)
    }
}

extension URLRequestFactoryTests {
    func test_constructAPIRequest() {
        // then
        XCTAssertNoThrow(try sut.constructURLRequestFromAPIRequest(apiRequestMock))
    }

    func test_constructAPIRequest_badScheme() {
        // given
        var baseConfig = APIBaseConfigMock()
        baseConfig.scheme = Seeds.string
        sut = URLRequestFactoryDefault(baseAPIConfig: baseConfig)
        // then
        XCTAssertThrowsError(try sut.constructURLRequestFromAPIRequest(apiRequestMock))
    }

    func test_constructAPIRequest_badHost() {
        // given
        var baseConfig = APIBaseConfigMock()
        baseConfig.host = ""
        sut = URLRequestFactoryDefault(baseAPIConfig: baseConfig)
        // then
        XCTAssertThrowsError(try sut.constructURLRequestFromAPIRequest(apiRequestMock))
    }

    func test_constructAPIRequest_badConfigPath() {
        // given
        var baseConfig = APIBaseConfigMock()
        baseConfig.path = "sdfsd"
        sut = URLRequestFactoryDefault(baseAPIConfig: baseConfig)
        // then
        XCTAssertThrowsError(try sut.constructURLRequestFromAPIRequest(apiRequestMock))
    }

    func test_constructAPIRequest_badRequestPath() {
        // given
        apiRequestMock.path = ""
        // then
        XCTAssertThrowsError(try sut.constructURLRequestFromAPIRequest(apiRequestMock))
    }
}
