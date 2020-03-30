import Foundation
import RxSwift
import RxCocoa

public protocol APIService {
    func response<R: APIRequest>(forWebRequest webRequest: R) -> Observable<R.ResponseJSONType>
}

public final class APIServiceDefault {

    public let apiConfig: APIConfig
    public let urlSession: URLSession
    public let jsonDecoder: JSONDecoder

    public init(apiConfig: APIConfig,
         urlSession: URLSession,
         jsonDecoder: JSONDecoder) {
        self.apiConfig = apiConfig
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

extension APIServiceDefault: APIService {
    public func response<R: APIRequest>(forWebRequest webRequest: R) -> Observable<R.ResponseJSONType> {
        Observable.just(webRequest)
            .compactMap { self.urlRequestFromAPIRequest($0) }
            .flatMap { self.urlSession.rx.data(request: $0) }
            .decode(using: jsonDecoder)
    }
}

private extension APIServiceDefault {
    func urlRequestFromAPIRequest<R: APIRequest>(_ apiRequest: R) -> URLRequest? {

        guard var urlComponents = URLComponents(string: apiConfig.basePath) else {
            return nil
        }

        urlComponents.path.append(apiRequest.pathExtension)

        urlComponents.queryItems?.append(contentsOf: apiRequest.queryItems)

        guard let finalURL = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = apiRequest.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = apiRequest.headers

        return urlRequest
    }
}


// TODO: make global
private extension Observable where Element == Data {
    func decode<T: Decodable>(using jsonDecoder: JSONDecoder) -> Observable<T> {
        map {
            try jsonDecoder.decode(T.self, from: $0)
        }
    }
}
