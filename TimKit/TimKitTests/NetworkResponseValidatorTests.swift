import XCTest
import TestTools
@testable import TimKit

class NetworkResponseValidatorTests: XCTestCase {

    var sut: NetworkRawResponseValidatorDefault!

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
        let data = try sut.validateResponse(responseMock).get()
        XCTAssertEqual(responseMock.data, data)
    }

    func test_validateResponse_noData() {
        // given
        responseMock.data = nil
        // then
        XCTAssertNil(sut.validateResponse(responseMock).unwrap())
        XCTAssertNil(sut.validateResponse(responseMock).unwrap())
    }

    func test_validateResponse_noInternalURLResponse() {
        // given
        responseMock.urlResponse = nil
        // then
        XCTAssertNil(sut.validateResponse(responseMock).unwrap())
    }

    func test_validateResponse_badStatusCode() {
        // given
        responseMock.urlResponse = HTTPURLResponse(url: Seeds.url,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)
        // then
        XCTAssertNil(sut.validateResponse(responseMock).unwrap())
    }

    func test_validateResponse_error() {
        // given
        responseMock.error = Seeds.error
        // then
        XCTAssertNil(sut.validateResponse(responseMock).unwrap())
    }
}
