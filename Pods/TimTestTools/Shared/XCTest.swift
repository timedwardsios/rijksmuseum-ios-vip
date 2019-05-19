import XCTest

private struct UnexpectedNilError: Error {}

public extension XCTestCase {

    func wait(for expectation: XCTestExpectation) {

        let timeout = TimeInterval(1)

        wait(for: [expectation], timeout: timeout)
    }
}

public extension XCTestCase {

    func loadSampleFileData(withName sampleFileName: String) -> Data? {

        let thisBundle = Bundle(for: type(of: self))

        let sampleFileURL = thisBundle.url(forResource: sampleFileName, withExtension: nil)!

        let sampleData = try? Data(contentsOf: sampleFileURL)

        return sampleData
    }
}
