
import XCTest
@testable import Service
import Utils

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!
    var apiConfig: APIConfig!
    var networkService:NetworkServiceMock!
    var apiRequest: APIRequest!

    override func setUp() {
        super.setUp()
        apiConfig = Seeds.apiConfig
        networkService = .init(resultToReturn: .success(Utils.Seeds.data))
        sut = .init(networkService: networkService,
                    apiConfig: apiConfig)
        apiRequest = Seeds.apiRequest
    }
}

extension APIRequestFactoryTests {

    func test_performRequest(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.performRequest(request: apiRequest) { (result) in
            if result.isSuccess {
                exp.fulfill()
            }
        }
        // then
        wait(for: [exp], timeout: 1)
    }

//    func test_performRequest_networkService(){
//        // given
//        let correctUrl = URL(string: "https://hostname.com/path/path?key=value&key=value")
//        let request = APIRequestMock()
//        // when
//        sut.performRequest(request: request) { _ in }
//        // then
//        XCTAssertEqual(self.networkService.performRequestArgs.count, 1)
//        XCTAssertEqual(self.networkService.performRequestArgs.last?.0, correctUrl)
//        XCTAssertEqual(self.networkService.performRequestArgs.last?.1, .GET)
//    }
//
//    func test_performRequest_callback(){
//        // given
//        let request = APIRequestMock()
//        let exp = XCTestExpectation()
//        // when
//        sut.performRequest(request: request) { (result) in
//            // then
//            XCTAssertEqual(self.networkService.result?.unwrap(), result.unwrap())
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_performRequest_error(){
//        // given
//        networkService.result = .failure(Seeds.error)
//        let request = APIRequestMock()
//        let exp = XCTestExpectation()
//        // when
//        sut.performRequest(request: request) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
}
