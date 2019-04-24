
import Foundation
@testable import Utils

class NetworkSessionMock: NetworkSession {

    let dataTask: NetworkSessionDataTaskMock
    var data:Data?
    var urlResponse: URLResponse?
    var error:Error?

    init(dataTask: NetworkSessionDataTaskMock,
         data: Data?,
         urlResponse: URLResponse?,
         error: Error?) {
        self.dataTask = dataTask
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    var dataTaskArgs = [URLRequest]()

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTask.Completion) -> DataTask {
        dataTaskArgs.append(request)
        dataTask.completion = {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return dataTask
    }
}
