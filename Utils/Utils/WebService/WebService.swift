import Foundation
import RxSwift
import RxCocoa

public protocol WebService {

    var apiConfig: WebServiceConfig {get}
    var urlSession: URLSession {get}
    var jsonDecoder: JSONDecoder {get}

    func performRequest<R: WebRequest>(_ webRequest: R) -> Observable<R.ResponseJSONType>
}

extension WebService {
    public func performRequest<R: WebRequest>(_ webRequest: R) -> Observable<R.ResponseJSONType> {
        Observable.just(webRequest)
            .compactMap { self.urlRequestFromAPIRequest($0) }
            .flatMap { self.urlSession.rx.data(request: $0) }
            .decode(using: jsonDecoder)
    }
}

private extension WebService {
    func urlRequestFromAPIRequest<R: WebRequest>(_ apiRequest: R) -> URLRequest? {

        guard var urlComponents = URLComponents(string: apiConfig.basePath) else {
            return nil
        }

        urlComponents.path.append(apiRequest.pathExtension)

        urlComponents.queryItems = apiConfig.queryItems + apiRequest.queryItems

        guard let finalURL = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = apiRequest.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = apiRequest.headers

        return urlRequest
    }
}
