
import Foundation

internal protocol NetworkSession {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionDataTask
}

extension URLSession: NetworkSession{
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
