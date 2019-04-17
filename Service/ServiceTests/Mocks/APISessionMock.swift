
import Foundation
@testable import Service

class APISessionMock: APISession {

    let dataTask: URLSessionDataTask
    init(dataTask: URLSessionDataTask) {
        self.dataTask = dataTask
    }

    var dataTask_invocations = [URL]()

    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask {
        dataTask_invocations.append(url)
        return dataTask
    }
}
