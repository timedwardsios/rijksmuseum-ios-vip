import Foundation

public protocol NetworkService {
    func processNetworkRequest(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

internal class NetworkServiceDefault {

    private let networkSession: NetworkSession
    private let networkRawResponseValidator: NetworkRawResponseValidator

    init(networkSession: NetworkSession,
         networkRawResponseValidator: NetworkRawResponseValidator) {
        self.networkSession = networkSession
        self.networkRawResponseValidator = networkRawResponseValidator
    }
}

extension NetworkServiceDefault: NetworkService {

    func processNetworkRequest(_ networkRequest: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        let urlRequest = urlRequestForNetworkRequest(networkRequest)

        let dataTask = dataTaskFromURLRequest(urlRequest, completion: completion)

        startDataTask(dataTask)
    }
}

private extension NetworkServiceDefault {

    struct NetworkRawResponseDefault: NetworkRawResponse {
        var data: Data?
        var urlResponse: URLResponse?
        var error: Error?
    }
}

private extension NetworkServiceDefault {

    func urlRequestForNetworkRequest(_ networkRequest: NetworkRequest) -> URLRequest {
        var urlRequest = URLRequest(url: networkRequest.url)
        urlRequest.httpMethod = networkRequest.method.rawValue
        return urlRequest
    }

    func dataTaskFromURLRequest(_ urlRequest: URLRequest,
                                completion: @escaping (Result<Data, Error>) -> Void) -> NetworkSessionDataTask {

        let dataTask = networkSession.dataTask(with: urlRequest) { [weak self] in
            guard let self = self else {
                return
            }

            let networkRawResponse = NetworkRawResponseDefault(data: $0, urlResponse: $1, error: $2)

            let validationResult = self.networkRawResponseValidator.validateResponse(networkRawResponse)

            completion(validationResult)
        }
        return dataTask
    }

    func startDataTask(_ dataTask: NetworkSessionDataTask) {
        dataTask.resume()
    }
}
