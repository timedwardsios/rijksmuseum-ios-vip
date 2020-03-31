@testable import MuseumCore
import TestKit
import XCTest

class ArtistFactoryTests: XCTestCase {
    var sut: ArtistFactoryDefault!

    var jsonDecoderServiceSpy: JSONDecoderServiceSpy!

    override func setUp() {
        super.setUp()
        jsonDecoderServiceSpy = JSONDecoderServiceSpy()
        sut = ArtistFactoryDefault(jsonDecoderService: jsonDecoderServiceSpy)
    }
}

extension ArtistFactoryTests {
    func test_createArt() throws {
        // given
        guard let data = loadSampleFileData(withName: "SearchSample.json") else {
            XCTFail("Should return data")
            return
        }
        // when then
        XCTAssertNoThrow(try sut.constructArtists(fromJSONData: data))
        XCTAssertEqual([data], jsonDecoderServiceSpy.decodeArgs)
    }

    func test_createArt_badData() throws {
        // when then
        XCTAssertThrowsError(try sut.constructArtists(fromJSONData: Seeds.data))
    }
}
