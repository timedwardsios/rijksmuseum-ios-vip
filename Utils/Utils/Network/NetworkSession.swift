
import Foundation

protocol NetworkSession {
    typealias DataTask = NetworkSessionDataTask
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTask.Completion) -> DataTask
}

extension URLSession: NetworkSession{
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTask.Completion) -> DataTask {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
