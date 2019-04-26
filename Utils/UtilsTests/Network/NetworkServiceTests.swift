
import XCTest
import UtilsTestTools
@testable import Utils

class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceDefault!
    var networkResponseValidatorSpy: NetworkResponseValidatorSpy!
    var networkSessionSpy: NetworkSessionSpy!
    var dataTaskSpy: NetworkSessionDataTaskSpy!

    var networkRequestMock:NetworkRequestMock!

    override func setUp() {
        super.setUp()
        networkResponseValidatorSpy = .init(validateResponseAndUnwrapDataResult: .success(Seeds.data))
        networkRequestMock = .init()
        dataTaskSpy = NetworkSessionDataTaskSpy()
        networkSessionSpy = .init(dataTask: dataTaskSpy,
                               data: Seeds.data,
                               urlResponse: Seeds.urlResponse,
                               error: nil)
        sut = .init(networkSession: networkSessionSpy,
                    networkResponseValidator: networkResponseValidatorSpy)
    }
}

extension NetworkServiceTests {

    func test_processRequest_callback(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequestMock) { (result) in
            // then
            XCTAssertEqual(self.networkResponseValidatorSpy.validateResponseAndUnwrapDataResult.unwrap(), result.unwrap())
            exp.fulfill()
        }
        wait(exp)
    }

    func test_processRequest_networkSessionSpy(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequestMock) { (result) in
            // then
            XCTAssertEqual(1, self.networkSessionSpy.dataTaskArgs.count)
            XCTAssertEqual(self.networkRequestMock.url, self.networkSessionSpy.dataTaskArgs.last?.url)
            XCTAssertEqual(self.networkRequestMock.method.rawValue, self.networkSessionSpy.dataTaskArgs.last?.httpMethod)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_processRequest_responseValidatorSpy(){
        // given
        let exp = XCTestExpectation()
        // when
        sut.processRequest(networkRequestMock) { (result) in
            // then
            XCTAssertEqual(1, self.networkResponseValidatorSpy.validateResponseAndUnwrapDataArgs.count)
            XCTAssertEqual(self.networkSessionSpy.data, self.networkResponseValidatorSpy.validateResponseAndUnwrapDataArgs.last?.data)
            XCTAssertEqual(self.networkSessionSpy.urlResponse, self.networkResponseValidatorSpy.validateResponseAndUnwrapDataArgs.last?.urlResponse)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_processRequest_POST(){
        // given
        let exp = XCTestExpectation()
        networkRequestMock.method = .POST
        // when
        sut.processRequest(networkRequestMock) { (result) in
            // then
            XCTAssertEqual(self.networkRequestMock.method.rawValue, self.networkSessionSpy.dataTaskArgs.last?.httpMethod)
            exp.fulfill()
        }
        wait(exp)
    }

    func test_processRequest_badValidation(){
        // given
        let exp = XCTestExpectation()
        networkResponseValidatorSpy.validateResponseAndUnwrapDataResult = .failure(Seeds.error)
        // when
        sut.processRequest(networkRequestMock) { (result) in
            // then
            XCTAssertEqual(self.networkSessionSpy.data, self.networkResponseValidatorSpy.validateResponseAndUnwrapDataArgs.last?.data)
            XCTAssertEqual(self.networkSessionSpy.urlResponse, self.networkResponseValidatorSpy.validateResponseAndUnwrapDataArgs.last?.urlResponse)
            exp.fulfill()
        }
        wait(exp)
    }
}

