import Foundation

public protocol URLSession {
    func dataTaskPublisher(for url: URL) -> Foundation.URLSession.DataTaskPublisher
}

extension Foundation.URLSession: URLSession {}
