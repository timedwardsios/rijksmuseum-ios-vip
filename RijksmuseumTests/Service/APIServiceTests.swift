
import XCTest
@testable import Rijksmuseum

class APIServiceTests: XCTestCase {
    // MARK: mocks
    class APISessionMock: APISession {
        let dataTask:URLSessionDataTaskMock
        init(dataTask:URLSessionDataTaskMock) {
            self.dataTask = dataTask
        }
        var dataTask_invocations = 0
        func dataTask(with url: URL,
                      completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask {
            dataTask_invocations += 1
            dataTask.url = url
            dataTask.completion = completionHandler
            return dataTask
        }
    }

    class URLSessionDataTaskMock: URLSessionDataTask{
        var validResponseFormat = true
        var includeData = true
        var statusCode = 200
        var url:URL!
        var completion:APISession.DataTaskCompletion!
        override func resume() {
            var data:Data?
            if includeData == true {
                data = Seeds.API.Endpoint.collection.data()
            }
            let response:URLResponse
            if validResponseFormat == true{
                response = HTTPURLResponse(url: url,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)!
            } else {
                response = URLResponse()
            }
            completion(data, response, nil)
        }
    }

    // MARK: init
    var sut: APIService!
    var apiSession:APISessionMock!
    var apiConfig:Seeds.API.Config!
    var dataTask:URLSessionDataTaskMock!
    override func setUp() {
        super.setUp()
        dataTask = URLSessionDataTaskMock()
        apiSession = APISessionMock(dataTask: dataTask)
        apiConfig = Seeds.API.Config()
        sut = APIService(apiSession: apiSession,
                         apiConfig: apiConfig)
    }
    // MARK: tests
    func test_performGet(){
        // given
        let request = Seeds.API.Request()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
    }

    func test_performGet_apiSession_called(){
        // given
        let request = Seeds.API.Request()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
        // then
        XCTAssert(apiSession.dataTask_invocations == 1,
                  "Should invoke apiSession once")
    }

    func test_performGet_apiSession_url(){
        // given
        let request = Seeds.API.Request()
        // when
        sut.performGet(request: request,
                       completion: {_ in})
        // then
        XCTAssert(apiSession.dataTask.url == Seeds.API.fullUrl(),
                  "Should invoke apiSession with correct URL")
    }

    func test_performGet_callback(){
        // given
        let exp = XCTestExpectation(description: "Should complete with result")
        let request = Seeds.API.Request()
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
        let request = Seeds.API.Request()
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
        let request = Seeds.API.Request()
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .success(let data) = result {
                let dataCount = Seeds.API.Endpoint.collection.data().count
                XCTAssert(dataCount == data.count,
                          "Should complete with correct data")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_responseFormatError(){
        // given
        let exp = XCTestExpectation(description: "Should complete with format error")
        let request = Seeds.API.Request()
        apiSession.dataTask.validResponseFormat = false
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(let error) = result {
                if case APIService.ServiceError.responseFormatError = error {
                    exp.fulfill()
                }
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_statusCodeError(){
        // given
        let exp = XCTestExpectation(description: "Should complete with status code error")
        let request = Seeds.API.Request()
        dataTask.statusCode = 999
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(let error) = result {
                if case APIService.ServiceError.statusCodeError = error {
                    exp.fulfill()
                }
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func test_performGet_callback_dataError(){
        // given
        let exp = XCTestExpectation(description: "Should complete with data error")
        let request = Seeds.API.Request()
        dataTask.includeData = false
        // when
        sut.performGet(request: request) { (result) in
            // then
            if case .failure(let error) = result {
                if case APIService.ServiceError.dataError = error {
                    exp.fulfill()
                }
            }
        }
        wait(for: [exp], timeout: 1)
    }
}

