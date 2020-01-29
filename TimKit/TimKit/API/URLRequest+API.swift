import Foundation

enum URLRequestError: LocalizedError {
    case unableToConstructURL
}

extension URLRequest {
    init?(fromAPIConfig apiConfig: APIConfig,
          apiRequest: APIRequest) {

        let urlComponents = URLComponents(apiConfig: apiConfig, apiRequest: apiRequest)

        guard let url = urlComponents.url else {
            return nil
        }

        self = .init(url: url)

        httpMethod = apiRequest.method.rawValue
    }
}

private extension URLComponents {
    init(apiConfig: APIConfig,
         apiRequest: APIRequest) {

        self = .init()

        scheme = apiConfig.scheme.rawValue
        host = apiConfig.hostname.rawValue
        path = apiConfig.path
        queryItems = apiConfig.queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) })

        path.append(apiRequest.path)
        queryItems?.append(contentsOf: apiRequest.queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) }))
    }
}
