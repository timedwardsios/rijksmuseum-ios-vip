import XCTest
import TestTools
@testable import MuseumKit

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension APIRequestFactoryTests {

    func test_createRequest() {
        let request = sut.apiRequest(fromAPIEndpoint: .art)
        XCTAssertEqual("/collection", request.path)
        XCTAssertEqual(3, request.queryItems.count)
    }
}
