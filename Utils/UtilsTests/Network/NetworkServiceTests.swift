
import XCTest
@testable import Utils

class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceDefault!
    var networkResponseValidator: NetworkResponseValidatorMock!
    var networkRequest:NetworkRequestMock!
    var dataTask: NetworkSessionDataTaskMock!
    var networkSession:NetworkSessionMock!

    override func setUp() {
        super.setUp()
        networkResponseValidator = .init(resultToReturn: .success(Seeds.data))
        networkRequest = .init(url: Seeds.url, method: .GET)
        dataTask = NetworkSessionDataTaskMock()
        networkSession = .init(dataTask: dataTask,
                               data: Seeds.data,
                               urlResponse: Seeds.urlResponse,
                               error: nil)
        sut = .init(networkSession: networkSession,
                    networkResponseValidator: networkResponseValidator)
    }
}

extension NetworkServiceTests {

    func test_processRequest_callback(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if let data = result.unwrap() {
                XCTAssertEqual(self.networkSession.data, data)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_processRequest_networkSession(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isSuccess {
                XCTAssertEqual(self.networkSession.dataTask_invocations.count, 1)
                XCTAssertEqual(self.networkSession.dataTask_invocations.last?.url, self.networkRequest.url)
                XCTAssertEqual(self.networkSession.dataTask_invocations.last?.httpMethod, self.networkRequest.method.rawValue)
                XCTAssertEqual(self.networkSession.dataTask.resume_invocations, 1)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_processRequest_responseValidator(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isSuccess {
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.count, 1)
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.data, self.networkSession.data)
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.urlResponse, self.networkSession.urlResponse)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_processRequest_POST(){
        // given
        let exp = XCTestExpectation()
        networkRequest.method = .POST
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isSuccess {
                XCTAssertEqual(self.networkSession.dataTask_invocations.last?.httpMethod, self.networkRequest.method.rawValue)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_processRequest_badValidation(){
        // given
        let exp = XCTestExpectation()
        networkResponseValidator.resultToReturn = .failure(Seeds.error)
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isFailure {
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.data, self.networkSession.data)
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.urlResponse, self.networkSession.urlResponse)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }
}

