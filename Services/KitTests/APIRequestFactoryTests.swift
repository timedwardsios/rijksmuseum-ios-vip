
import XCTest
import TestTools
@testable import Services

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension APIRequestFactoryTests {
    
    func test_createRequest() {
        let request = sut.createRequest(fromAPIEndpoint: .art)
        XCTAssertEqual("/collection", request.path)
        XCTAssertEqual(3, request.queryItems.count)
    }
}
