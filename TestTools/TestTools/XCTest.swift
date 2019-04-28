
import XCTest
// swiftlint:disable force_try

private struct UnexpectedNilError: Error {}

public func XCTAssertUnwrapOptional<T>(_ variable: T?, message: String = "Unexpected nil variable", file: StaticString = #file, line: UInt = #line) throws -> T {
    guard let variable = variable else {
        XCTFail(message, file: file, line: line)
        throw UnexpectedNilError()
    }
    return variable
}

public extension XCTestCase {
    func wait(for expectation:XCTestExpectation){
        let timeout = TimeInterval(1)
        wait(for: [expectation], timeout: timeout)
    }
}

public extension XCTestCase {
    func loadSampleFileData(withName sampleFileName:String) -> Data? {
        let thisBundle = Bundle(for: type(of: self))
        let sampleFileURL = thisBundle.url(forResource: sampleFileName, withExtension: nil)!
        let sampleData = try? Data(contentsOf: sampleFileURL)
        return sampleData
    }

    func loadSampleFileContents(withName sampleFileName:String) -> String? {
        let thisBundle = Bundle(for: type(of: self))
        let sampleFileURL = thisBundle.url(forResource: sampleFileName, withExtension: nil)!
        let sampleContents = try? String(contentsOf: sampleFileURL)
        return sampleContents
    }
}
