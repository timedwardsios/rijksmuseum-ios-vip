@testable import MuseumCore
import TestKit
import Utils
import XCTest

class APIServiceTests: XCTestCase {
    var sut: APIServiceDefault!

    var urlRequestFactorySpy: URLRequestFactorySpy!

    var networkSessionDataTaskSpy: NetworkSessionDataTaskSpy!

    var networkSessionSpy: NetworkSessionSpy!

    var networkResponseValidatorSpy: NetworkResponseValidatorSpy!

    var apiRequestMock: APIRequestMock!

    override func setUp() {
        super.setUp()

        apiRequestMock = APIRequestMock()

        urlRequestFactorySpy = URLRequestFactorySpy()
        networkSessionDataTaskSpy = NetworkSessionDataTaskSpy()
        networkSessionSpy = NetworkSessionSpy(dataTask: networkSessionDataTaskSpy)
        networkResponseValidatorSpy = NetworkResponseValidatorSpy()

        sut = APIServiceDefault(
            urlRequestFactory: urlRequestFactorySpy,
            networkSession: networkSessionSpy,
            networkResponseValidator: networkResponseValidatorSpy
        )
    }
}

extension APIServiceTests {
    func test_performAPIRequest_callback() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.performAPIRequest(apiRequestMock) { result in

            // then
            guard case let .success(data) = result else {
                XCTFail("Callback should contain data")
                return
            }

            XCTAssertEqual(self.networkResponseValidatorSpy.validateResponseResult.unwrap(), data)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_performAPIRequest_urlRequestFactory() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.performAPIRequest(apiRequestMock) { _ in

            // then
            XCTAssertEqual(1, self.urlRequestFactorySpy.constructURLRequestFromAPIRequestArgs.count)
            let lastRequest = self.urlRequestFactorySpy
                .constructURLRequestFromAPIRequestArgs
                .last as? APIRequestMock
            XCTAssertEqual(self.apiRequestMock, lastRequest)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_performAPIRequest_networkSession() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.performAPIRequest(apiRequestMock) { _ in

            // then
            XCTAssertEqual(1, self.networkSessionSpy.dataTaskArgs.count)
            XCTAssertEqual(
                self.urlRequestFactorySpy.constructURLRequestFromAPIRequestResult.unwrap(),
                self.networkSessionSpy.dataTaskArgs.last
            )

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_performAPIRequest_networkResponseValidator() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.performAPIRequest(apiRequestMock) { _ in

            XCTAssertEqual(1, self.networkResponseValidatorSpy.validateResponseArgs.count)
            let lastResponse = self.networkResponseValidatorSpy.validateResponseArgs.last

            XCTAssertEqual(self.networkSessionSpy.data, lastResponse?.data)
            XCTAssertEqual(self.networkSessionSpy.urlResponse, lastResponse?.urlResponse)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_performAPIRequest_urlRequestFactoryFailure() {
        // given
        let exp = expectation(description: "Should callback")
        urlRequestFactorySpy.constructURLRequestFromAPIRequestResult =
            .failure(URLRequestFactoryError.invalidPath)
        // when
        sut.performAPIRequest(apiRequestMock) { result in
            // then
            XCTAssertNil(result.unwrap())
            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_performAPIRequest_networkResponseValidatorFailure() {
        // given
        let exp = expectation(description: "Should callback")
        let error = APIResponseValidatorError.rawResponseError(Seeds.error)
        networkResponseValidatorSpy.validateResponseResult = .failure(error)
        // when
        sut.performAPIRequest(apiRequestMock) { result in
            // then
            XCTAssertNil(result.unwrap())
            exp.fulfill()
        }
        wait(for: exp)
    }
}
