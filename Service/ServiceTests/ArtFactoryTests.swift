
import XCTest
import TestingUtils
@testable import Service

class ArtFactoryTests: XCTestCase {

    var sut: ArtFactoryDefault!
    var jsonDecoderService: JSONDecoderServiceSpy!

    override func setUp() {
        super.setUp()
        jsonDecoderService = .init()
        sut = .init(jsonDecoderService: jsonDecoderService)
    }
}

extension ArtFactoryTests {
    func test_createArt() throws {
        let art = try XCTAssertUnwrap(sut.createArt(fromJSONData: Seeds.data))
    }
}
