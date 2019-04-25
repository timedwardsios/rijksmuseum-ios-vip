
import XCTest
import TestUtils
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
            if let expectedData = self.networkResponseValidator.resultToReturn.unwrap(),
                let actualData = result.unwrap(){

                XCTAssertEqual(expectedData, actualData)
                exp.fulfill()
            }
        }
        wait(exp)
    }

    func test_processRequest_networkSession(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isSuccess {
                XCTAssertEqual(self.networkSession.dataTaskArgs.count, 1)
                XCTAssertEqual(self.networkSession.dataTaskArgs.last?.url, self.networkRequest.url)
                XCTAssertEqual(self.networkSession.dataTaskArgs.last?.httpMethod, self.networkRequest.method.rawValue)
                XCTAssertEqual(self.networkSession.dataTask.resumeArgs, 1)
                exp.fulfill()
            }
        }
        wait(exp)
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
        wait(exp)
    }

    func test_processRequest_POST(){
        // given
        let exp = XCTestExpectation()
        networkRequest.method = .POST
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isSuccess {
                XCTAssertEqual(self.networkSession.dataTaskArgs.last?.httpMethod, self.networkRequest.method.rawValue)
                exp.fulfill()
            }
        }
        wait(exp)
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
        wait(exp)
    }
}

