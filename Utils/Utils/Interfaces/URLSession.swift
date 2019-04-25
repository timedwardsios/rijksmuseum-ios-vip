
import Foundation

protocol URLSession {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping URLSessionDataTask.Completion) -> URLSessionDataTask
}

extension Foundation.URLSession: URLSession{
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as Foundation.URLSessionDataTask
    }
}
