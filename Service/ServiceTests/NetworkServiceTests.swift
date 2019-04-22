
import XCTest
@testable import Service

class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceDefault!
    var networkSession:NetworkSessionMock!

    override func setUp() {
        super.setUp()
        networkSession = .init()
        networkSession.data = "{}".data(using: .utf8)
        networkSession.response = HTTPURLResponse(url: URL(string: "https://www.google.com")!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        sut = .init(networkSession: networkSession)
    }
}

extension NetworkServiceTests {
    func test_performRequest_GET(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.performRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
            // then
            if let data = result.unwrap() {
                XCTAssertEqual(self.networkSession.data, data)
                XCTAssertEqual(self.networkSession.dataTask_invocations.count, 1)
                XCTAssertEqual(self.networkSession.dataTask_invocations.last, Seeds.url)
                XCTAssertEqual(self.networkSession.dataTask.resume_invocations, 1)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performRequest_GET_noData(){
        // given
        networkSession.data = nil
        let exp = XCTestExpectation()
        // when
        sut.performRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
            // then
            if result.isFailure {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performRequest_GET_noResponse(){
        // given
        networkSession.response = nil
        let exp = XCTestExpectation()
        // when
        sut.performRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
            // then
            if result.isFailure {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performRequest_GET_badStatusCode(){
        // given
        networkSession.response = HTTPURLResponse(url: Seeds.url, statusCode: 404, httpVersion: nil, headerFields: nil)
        let exp = XCTestExpectation()
        // when
        sut.performRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
            // then
            if result.isFailure {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performRequest_GET_error(){
        // given
        networkSession.error = Seeds.error
        let exp = XCTestExpectation()
        // when
        sut.performRequest(atUrl: Seeds.url, usingMethod: .GET) { (result) in
            // then
            if result.isFailure {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }
}

