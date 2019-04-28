
import XCTest
import TestTools
@testable import Utils

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

    func test_validateResponse_noData(){
        // given
        responseMock.data = nil
        // then
        XCTAssertTrue(sut.validateResponse(responseMock).isFailure)
        XCTAssertTrue(sut.validateResponse(responseMock).isFailure)
    }

    func test_validateResponse_noInternalURLResponse(){
        // given
        responseMock.urlResponse = nil
        // then
        XCTAssertTrue(sut.validateResponse(responseMock).isFailure)
    }

    func test_validateResponse_badStatusCode(){
        // given
        responseMock.urlResponse = HTTPURLResponse(url: Seeds.url,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)
        // then
        XCTAssertTrue(sut.validateResponse(responseMock).isFailure)
    }

    func test_validateResponse_error(){
        // given
        responseMock.error = Seeds.error
        // then
        XCTAssertTrue(sut.validateResponse(responseMock).isFailure)
    }
}

