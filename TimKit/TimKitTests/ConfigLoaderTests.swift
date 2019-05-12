import XCTest
import TestTools
@testable import TimKit

class ConfigLoaderTests: XCTestCase {

    var sut: ConfigLoaderDefault!
    var propertyListDecoderSpy: PropertyListDecoderSpy!

    override func setUp() {
        super.setUp()

        propertyListDecoderSpy = PropertyListDecoderSpy()
        sut = .init(propertyListDecoder: propertyListDecoderSpy)
    }
}

extension ConfigLoaderTests {
    func test_getConfig() throws {
        // given
        let sampleData = loadSampleFileData(withName: "config.plist")
        let bundle = Bundle(for: type(of: self))
        // when
        let configResult: Result<ConfigMock, ConfigLoaderError> = sut.getConfig(forBundle: bundle)
        // then
        let config = try XCTAssertUnwrapOptional(configResult.unwrap())
        XCTAssertEqual("5872485F-B1F5-4470-ADF7-BDD1C69E69DD", config.seedKey)
        XCTAssertEqual(1, propertyListDecoderSpy.decodeArgs.count)
        XCTAssertEqual(sampleData, propertyListDecoderSpy.decodeArgs.last)
    }

    func test_getConfig_badBundle() {
        // given
        let bundle = Bundle.main
        // when
        let configResult: Result<ConfigMock, ConfigLoaderError> = sut.getConfig(forBundle: bundle)
        // then
        XCTAssertNil(configResult.unwrap())
    }
}
