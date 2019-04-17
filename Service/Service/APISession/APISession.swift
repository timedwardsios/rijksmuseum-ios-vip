
import Foundation

protocol APISession {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletion)-> URLSessionDataTask
}

extension URLSession:APISession{}
