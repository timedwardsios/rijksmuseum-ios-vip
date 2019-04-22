
import Foundation
@testable import Service

class NetworkSessionMock: NetworkSession {

    let dataTask = NetworkSessionDataTaskMock()
    var data:Data?
    var response: URLResponse?
    var error:Error?

    var dataTask_invocations = [URL]()

    func dataTask(with url: URL, completionHandler: @escaping DataTask.Completion) -> DataTask {
        dataTask_invocations.append(url)
        dataTask.completion = {
            completionHandler(self.data, self.response, self.error)
        }
        return dataTask
    }
}
