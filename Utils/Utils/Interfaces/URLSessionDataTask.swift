
import Foundation

protocol URLSessionDataTask {
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    func resume()
}

extension Foundation.URLSessionDataTask: URLSessionDataTask{}
