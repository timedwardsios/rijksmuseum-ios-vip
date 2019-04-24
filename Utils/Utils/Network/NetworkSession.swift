
import Foundation

protocol NetworkSession {
    typealias DataTask = NetworkSessionDataTask
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTask.Completion)-> DataTask
}

extension URLSession: NetworkSession{
    func dataTask(with url: URL, completionHandler: @escaping DataTask.Completion) -> DataTask {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}
