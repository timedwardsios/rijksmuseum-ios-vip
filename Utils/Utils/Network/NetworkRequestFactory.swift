
import Foundation

public protocol NetworkRequestFactory {
    func createRequest(url: URL, method: NetworkMethod)->NetworkRequest
}

class NetworkRequestFactoryDefault: NetworkRequestFactory{
    private struct NetworkRequestDefault: NetworkRequest {
        var urlRequest: URLRequest
    }

    func createRequest(url: URL, method: NetworkMethod) -> NetworkRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return NetworkRequestDefault(urlRequest: urlRequest)
    }
}
