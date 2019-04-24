
import XCTest
@testable import Utils

class NetworkResponseValidatorTests: XCTestCase {

    var sut: networkvali!
    var networkSession:NetworkSessionMock!

    override func setUp() {
        super.setUp()
        let dataTask = NetworkSessionDataTaskMock()
        let data = "{}".data(using: .utf8)
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        networkSession = .init(dataTask: dataTask, data: data, urlResponse: urlResponse, error: nil)
        sut = .init(networkSession: networkSession)
    }
}

extension NetworkResponseValidatorTests {

//    func test_processRequest_GET(){
//        // given
//        let exp = XCTestExpectation()
//        // when
//        sut.processRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
//            // then
//            if let data = result.unwrap() {
//                XCTAssertEqual(self.networkSession.data, data)
//                XCTAssertEqual(self.networkSession.dataTask_invocations.count, 1)
//                XCTAssertEqual(self.networkSession.dataTask_invocations.last, Seeds.url)
//                XCTAssertEqual(self.networkSession.dataTask.resume_invocations, 1)
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_processRequest_GET_noData(){
//        // given
//        networkSession.data = nil
//        let exp = XCTestExpectation()
//        // when
//        sut.processRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_processRequest_GET_noResponse(){
//        // given
//        networkSession.urlResponse = nil
//        let exp = XCTestExpectation()
//        // when
//        sut.processRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_processRequest_GET_badStatusCode(){
//        // given
//        networkSession.urlResponse = HTTPURLResponse(url: Seeds.url, statusCode: 404, httpVersion: nil, headerFields: nil)
//        let exp = XCTestExpectation()
//        // when
//        sut.processRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_processRequest_GET_error(){
//        // given
//        networkSession.error = Seeds.error
//        let exp = XCTestExpectation()
//        // when
//        sut.processRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
//            // then
//            if result.isFailure {
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 1)
//    }
}

