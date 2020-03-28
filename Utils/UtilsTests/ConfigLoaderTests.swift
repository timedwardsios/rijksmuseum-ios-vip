import XCTest
import TestKit
@testable import Utils

class ConfigLoaderTests: XCTestCase {

    var sut: ConfigLoaderDefault!

    var propertyListDecoderServiceSpy: PropertyListDecoderServiceSpy!

    override func setUp() {

        super.setUp()

        propertyListDecoderServiceSpy = PropertyListDecoderServiceSpy()

        sut = .init(propertyListDecoderService: propertyListDecoderServiceSpy)
    }
}

extension ConfigLoaderTests {

    func test_getConfig() throws {

        // given
        let sampleData = loadSampleFileData(withName: "config.plist")
        let bundle = Bundle(for: type(of: self))

        // when
        let config: ConfigMock = try sut.getConfig(forBundle: bundle)

        // then
        XCTAssertEqual("5872485F-B1F5-4470-ADF7-BDD1C69E69DD", config.seedKey)
        XCTAssertEqual(1, propertyListDecoderServiceSpy.decodeArgs.count)
        XCTAssertEqual(sampleData, propertyListDecoderServiceSpy.decodeArgs.last)
    }

    func test_getConfig_badBundle() throws {

        // given
        let bundle = Bundle.main

        // when
        XCTAssertThrowsError(try sut.getConfig(forBundle: bundle) as ConfigMock)
    }
}
