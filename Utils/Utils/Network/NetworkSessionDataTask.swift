
import Foundation

internal protocol NetworkSessionDataTask {
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    func resume()
}

extension URLSessionDataTask: NetworkSessionDataTask{}
