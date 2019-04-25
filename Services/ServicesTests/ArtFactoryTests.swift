
import XCTest
import TestingUtils
@testable import Services

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
        let data = loadSampleFileData(withName: "collection.json")
        XCTAssertNoThrow(try XCTAssertUnwrap(sut.createArts(fromJSONData: data)))
        XCTAssertEqual(1, jsonDecoderService.decodeArgs.count)
        XCTAssertEqual(data, jsonDecoderService.decodeArgs.last)
    }

    func test_createArt_badData() throws {
        XCTAssertThrowsError(try sut.createArts(fromJSONData: Seeds.data))
    }
}
