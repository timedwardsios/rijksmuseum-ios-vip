
import XCTest
@testable import Utils

class NetworkRequestFactoryTests: XCTestCase {

    var sut: NetworkRequestFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension NetworkRequestFactoryTests {
    func test_createRequest_GET (){
        // given
        let url = Seeds.url
        // when
        let request = sut.createRequest(url: url, method: .GET)
        // then
        XCTAssertEqual(url, request.urlRequest.url)
        XCTAssertEqual("GET", request.urlRequest.httpMethod)
    }

    func test_createRequest_POST(){
        // given
        let url = Seeds.url
        // when
        let request = sut.createRequest(url: url, method: .POST)
        // then
        XCTAssertEqual(url, request.urlRequest.url)
        XCTAssertEqual("POST", request.urlRequest.httpMethod)
    }
}

