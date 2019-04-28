
import Foundation

internal protocol NetworkSessionDataTask {
    func resume()
}

extension URLSessionDataTask: NetworkSessionDataTask{}
