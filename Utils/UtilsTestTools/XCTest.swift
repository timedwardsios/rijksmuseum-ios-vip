
import XCTest

private struct UnexpectedNilError: Error {}
public func XCTAssertUnwrap<T>(_ variable: T?, message: String = "Unexpected nil variable", file: StaticString = #file, line: UInt = #line) throws -> T {
    guard let variable = variable else {
        XCTFail(message, file: file, line: line)
        throw UnexpectedNilError()
    }
    return variable
}

public extension XCTestCase {
    func wait(_ expectation:XCTestExpectation){
        wait(for: [expectation], timeout: 1)
    }
}

public extension XCTestCase {
    func loadSampleFileData(withName fileName:String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileURL = bundle.url(forResource: fileName, withExtension: nil)!
        return try! Data(contentsOf: fileURL)
    }

    func loadSampleFileContents(withName fileName:String) -> String {
        let bundle = Bundle(for: type(of: self))
        let fileURL = bundle.url(forResource: fileName, withExtension: nil)!
        return try! String(contentsOf: fileURL)
    }
}
