import Foundation

enum WebRequestError: LocalizedError {
    case badURL

    var errorDescription: String? {
        switch self {
        case .badURL: return "Failed to generate URL from components"
        }
    }
}

extension WebRequest {
    func urlRequest(givenConfig config: WebServiceConfig) throws  -> URLRequest {

        let components = urlComponents(givenConfig: config)

        guard let url = components.url else {
            throw WebRequestError.badURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = self.headers

        return urlRequest
    }

    private func urlComponents(givenConfig config: WebServiceConfig) -> URLComponents {

        var components = URLComponents()

        components.scheme = config.urlScheme.rawValue
        components.host = config.hostname
        components.path = config.path + self.path

        components.queryItems = config.queryItems
            .merging(self.queryItems) { $1 }
            .map { URLQueryItem(name: $0.0, value: $0.1) }

        return components
    }
}
