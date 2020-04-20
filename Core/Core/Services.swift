import Foundation

public struct Services {

    public let rijkmuseumWebService: RijkmuseumWebService

    public init(urlSession: URLSession,
                jsonDecoder: JSONDecoder) {
        rijkmuseumWebService = .init(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
}
