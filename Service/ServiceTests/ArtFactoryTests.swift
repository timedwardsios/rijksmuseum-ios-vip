
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
        let data = loadSampleFileData(withName: "collection.json")
        let art = try XCTAssertUnwrap(sut.createArt(fromJSONData: data))
        XCTAssertEqual(1, jsonDecoderService.decodeArgs.count)
        XCTAssertEqual(data, jsonDecoderService.decodeArgs.last)
    }

    func test_createArt_badData() throws {
        XCTAssertThrowsError(try sut.createArt(fromJSONData: Seeds.data))
    }
}
