import Foundation

public protocol ServiceFactory {
    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
}

extension ServiceFactory {
    func resolve() -> ArtWebService {
        ArtWebService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
}
