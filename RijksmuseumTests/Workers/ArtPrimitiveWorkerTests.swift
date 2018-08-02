
import XCTest
@testable import Rijksmuseum

class ArtPrimitiveWorkerTests: XCTestCase {
    // MARK: mocks
    class ArtPrimitiveServiceMock: ArtPrimitiveService {
        var active = true
        var loadPrimitives_called = false
        func loadPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
            loadPrimitives_called = true
            let result = SharedMockData.ArtPrimitiveMock()
            completion(active ? .success([result]) : .failure(SharedMockData.ErrorMock()))
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
    func test_fetchPrimitives_forwarded_service(){
        sut.fetchPrimitives {_ in}
        XCTAssert(artPrimitiveService.loadPrimitives_called,
                  "Method should be forwarded to the service object")
    }

    func test_fetchPrimitives_return_success(){
        // given
        let exp = XCTestExpectation(description: "Should return success")
        // when
        sut.fetchPrimitives { (result) in
            // then
            guard case .success = result else {
                XCTFail("Didn't return success")
                return
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func test_fetchPrimitives_return_failure(){
        // given
        let exp = XCTestExpectation(description: "Should return failure")
        artPrimitiveService.active = false
        // when
        sut.fetchPrimitives { (result) in
            // then
            guard case .failure = result else {
                XCTFail("Didn't return failure")
                return
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
