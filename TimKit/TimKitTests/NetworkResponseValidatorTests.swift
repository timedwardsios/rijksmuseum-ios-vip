import XCTest
import TestKit
@testable import TimKit

class NetworkResponseValidatorTests: XCTestCase {

    var sut: APIResponseValidatorDefault!

    var responseMock: NetworkResponseMock!

    override func setUp() {
        super.setUp()

        sut = .init()

        responseMock = .init()
    }
}

extension NetworkResponseValidatorTests {

    func test_validateResponse() throws {

        // then
        let data = try sut.validateResponse(responseMock)
        XCTAssertEqual(responseMock.data, data)
    }

    func test_validateResponse_noData() {

        // given
        responseMock.data = nil

        // then
        XCTAssertThrowsError(try sut.validateResponse(responseMock))
    }

    func test_validateResponse_noInternalURLResponse() {

        // given
        responseMock.urlResponse = nil

        // then
        XCTAssertThrowsError(try sut.validateResponse(responseMock))
    }

    func test_validateResponse_badStatusCode() {

        // given
        responseMock.urlResponse = HTTPURLResponse(url: Seeds.url,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)

        // then
        XCTAssertThrowsError(try sut.validateResponse(responseMock))
    }

    func test_validateResponse_error() {

        // given
        responseMock.error = Seeds.error

        // then
        XCTAssertThrowsError(try sut.validateResponse(responseMock))
    }
}
