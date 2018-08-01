
import XCTest
@testable import Rijksmuseum

class ArtPrimitiveWorkerTests: XCTestCase {
    // MARK: mocks
    class ArtPrimitiveServiceMock: ArtPrimitiveService {
        var fetchPrimitives_called = false
        func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            fetchPrimitives_called = true
            let result = TestData.ArtPrimitiveMock()
            completion(.success([result]))
        }
    }

    // MARK: init
    var sut: ArtPrimitiveWorker!
    var artPrimitiveService: ArtPrimitiveServiceMock!
    override func setUp() {
        super.setUp()
        artPrimitiveService = ArtPrimitiveServiceMock()
        sut = ArtPrimitiveWorker(artPrimitiveSource: artPrimitiveService)
    }

    // MARK: tests
    func test_fetchPrimitives_success(){
        let exp = XCTestExpectation()
        sut.fetchPrimitives { (result) in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
