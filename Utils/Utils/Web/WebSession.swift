import Foundation

public protocol WebSession {
    func dataTaskPublisher(for urlRequest: URLRequest) -> Foundation.URLSession.DataTaskPublisher
}

extension URLSession: WebSession {}
