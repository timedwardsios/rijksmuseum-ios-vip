
import XCTest
import UtilsTestTools
@testable import Services

class ArtFactoryTests: XCTestCase {

    var sut: ArtFactoryDefault!
    
    var jsonDecoderServiceSpy: JSONDecoderServiceSpy!

    override func setUp() {
        super.setUp()
        jsonDecoderServiceSpy = .init()
        sut = .init(jsonDecoderService: jsonDecoderServiceSpy)
    }
}

extension ArtFactoryTests {
    func test_createArt() throws {
        let data = loadSampleFileData(withName: "collection.json")
        XCTAssertNoThrow(try XCTAssertUnwrap(sut.createArts(fromJSONData: data)))
        XCTAssertEqual([data], jsonDecoderServiceSpy.decodeArgs)
    }

    func test_createArt_badData() throws {
        XCTAssertThrowsError(try sut.createArts(fromJSONData: Seeds.data))
    }
}
