
import XCTest
@testable import Service

class APIServiceTests: XCTestCase {

    var sut: APIServiceDefault!
    var apiSessionMock:APISessionMock!
    var dataTaskMock:URLSessionDataTaskMock!
    var apiConfigMock:APIConfigMock!

    override func setUp() {
        super.setUp()
        apiConfigMock = APIConfigMock()

        dataTaskMock = .init()
        apiSessionMock = .init(dataTask: dataTaskMock)
        sut = .init(apiSession: apiSessionMock,
                    apiConfig: apiConfigMock)
    }
}

extension APIServiceTests {
    func test_performGet(){
        // given
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
    }

    func test_performGet_apiSession_called(){
        // given
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
        // then
        XCTAssert(apiSessionMock.dataTask_invocations.count == 1,
                  "Should invoke apiSession once")
    }

    func test_performGet_apiSession_url(){
        // given
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
        // then

        XCTAssert(apiSessionMock.dataTask_invocations.first != nil,
                  "Should invoke apiSession with correct URL")
    }

    func test_performGet_callback(){
        // given
        let exp = XCTestExpectation(description: "Should complete with result")
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request) { (result) in
            // then
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_success(){
        // given
        let exp = XCTestExpectation(description: "Should complete with success")
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .success = result {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_data(){
        // given
        let exp = XCTestExpectation(description: "")
        let request = ModelMock.APIRequest()
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .success(let data) = result {
                let dataCount = ModelMock.API.Endpoint.collection.data().count
                XCTAssert(dataCount == data.count,
                          "Should complete with correct data")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_responseFormatError(){
        // given
        let exp = XCTestExpectation(description: "Should fail when corrupted response")
        let request = ModelMock.APIRequest()
//        apiSessionMock.dataTask.validResponseFormat = false
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(_) = result {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_statusCodeError(){
        // given
        let exp = XCTestExpectation(description: "Should fail when bad status code")
        let request = ModelMock.APIRequest()
//        dataTaskMock.statusCode = 999
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(_) = result {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_dataError(){
        // given
        let exp = XCTestExpectation(description: "Should fail when no data")
        let request = ModelMock.APIRequest()
//        dataTaskMock.includeData = false
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(_) = result {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }
}

