import Foundation

public class ServiceFactory {

    let artWebService: ArtWebService

    public init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.artWebService = ArtWebService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
}
