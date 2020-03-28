import Foundation

public protocol WebSession {
    typealias DataTaskPublisher = Foundation.URLSession.DataTaskPublisher
    func dataTaskPublisher(for urlRequest: URLRequest) -> Foundation.URLSession.DataTaskPublisher
}

extension URLSession: WebSession {}
