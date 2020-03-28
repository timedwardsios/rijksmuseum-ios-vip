import Foundation
import TestKit
@testable import Utils

class NetworkSessionSpy: TimKit.URLSession {

    var dataTask: NetworkSessionDataTaskSpy

    init(dataTask: NetworkSessionDataTaskSpy) {
        self.dataTask = dataTask
    }

    var data: Data? = Seeds.data
    var urlResponse: URLResponse? = Seeds.urlResponse
    var error: Error?

    var dataTaskArgs = [URLRequest]()

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        dataTaskArgs.append(request)

        dataTask.completion = {
            completionHandler(self.data, self.urlResponse, self.error)
        }

        return dataTask
    }
}
