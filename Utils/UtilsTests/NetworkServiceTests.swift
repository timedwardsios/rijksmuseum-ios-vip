
import XCTest
import TestingUtils
@testable import Utils

class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceDefault!
    var networkResponseValidator: NetworkResponseValidatorSpy!
    var networkRequest:NetworkRequestMock!
    var dataTask: URLSessionDataTaskSpy!
    var urlSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        networkResponseValidator = .init(validateResponseAndUnwrapDataResult: .success(Seeds.data))
        networkRequest = .init(url: Seeds.url, method: .GET)
        dataTask = URLSessionDataTaskSpy()
        urlSession = .init(dataTask: dataTask,
                               data: Seeds.data,
                               urlResponse: Seeds.urlResponse,
                               error: nil)
        sut = .init(urlSession: urlSession,
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
            if let expectedData = self.networkResponseValidator.validateResponseAndUnwrapDataResult.unwrap(),
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
                XCTAssertEqual(self.urlSession.dataTaskArgs.count, 1)
                XCTAssertEqual(self.urlSession.dataTaskArgs.last?.url, self.networkRequest.url)
                XCTAssertEqual(self.urlSession.dataTaskArgs.last?.httpMethod, self.networkRequest.method.rawValue)
                XCTAssertEqual(self.urlSession.dataTask.resumeArgs, 1)
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
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.data, self.urlSession.data)
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.urlResponse, self.urlSession.urlResponse)
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
                XCTAssertEqual(self.urlSession.dataTaskArgs.last?.httpMethod, self.networkRequest.method.rawValue)
                exp.fulfill()
            }
        }
        wait(exp)
    }

    func test_processRequest_badValidation(){
        // given
        let exp = XCTestExpectation()
        networkResponseValidator.validateResponseAndUnwrapDataResult = .failure(Seeds.error)
        // when
        sut.processRequest(networkRequest) { (result) in
            // then
            if result.isFailure {
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.data, self.urlSession.data)
                XCTAssertEqual(self.networkResponseValidator.validateResponseAndUnwrapDataArgs.last?.urlResponse, self.urlSession.urlResponse)
                exp.fulfill()
            }
        }
        wait(exp)
    }
}

