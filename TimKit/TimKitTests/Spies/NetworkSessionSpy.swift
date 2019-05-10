import Foundation
@testable import TimKit

class NetworkSessionSpy: Utils.NetworkSession {

    let dataTask: NetworkSessionDataTaskSpy
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    init(dataTask: NetworkSessionDataTaskSpy,
         data: Data?,
         urlResponse: URLResponse?,
         error: Error?) {
        self.dataTask = dataTask
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    var dataTaskArgs = [URLRequest]()

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionDataTask {
        dataTaskArgs.append(request)
        dataTask.completion = {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return dataTask
    }
}
