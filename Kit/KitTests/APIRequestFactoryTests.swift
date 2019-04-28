
import XCTest
import TestTools
@testable import Kit

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension APIRequestFactoryTests {
    
    func test_createRequest() {
        let request = sut.createAPIRequest(fromAPIEndpoint: .art)
        XCTAssertEqual("/collection", request.path)
        XCTAssertEqual(3, request.queryItems.count)
    }
}
