import Foundation

public protocol ServiceFactory {
    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
}

extension ServiceFactory {
    func resolve() -> RijkmuseumWebService {
        RijkmuseumWebService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
}
