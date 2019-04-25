
import Foundation
@testable import Utils

class URLSessionMock: Utils.URLSession {

    let dataTask: URLSessionDataTaskSpy
    var data:Data?
    var urlResponse: URLResponse?
    var error:Error?

    init(dataTask: URLSessionDataTaskSpy,
         data: Data?,
         urlResponse: URLResponse?,
         error: Error?) {
        self.dataTask = dataTask
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    var dataTaskArgs = [URLRequest]()

    func dataTask(with request: URLRequest, completionHandler: @escaping Utils.URLSessionDataTask.Completion) -> Utils.URLSessionDataTask {
        dataTaskArgs.append(request)
        dataTask.completion = {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return dataTask
    }
}
