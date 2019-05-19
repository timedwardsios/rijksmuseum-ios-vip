import Foundation

public protocol NetworkSessionDataTask {

    func resume()

    func cancel()
}

extension URLSessionDataTask: NetworkSessionDataTask {}
