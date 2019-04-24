
import XCTest
@testable import Utils

class NetworkResponseFactoryTests: XCTestCase {

    var sut: NetworkResponseFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension NetworkResponseFactoryTests {
    func test_createRequest_GET (){
        // given
        let result:Result<Data, Error> = .success(Seeds.data)
        // when
        let response = sut.createResponse(result: result)
        // then
        XCTAssertEqual(result.unwrap(), response.result.unwrap())
    }
}

