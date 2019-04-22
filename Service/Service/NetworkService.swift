
import Foundation

enum NetworkMethod {
    case GET
}

protocol NetworkService {
    func performRequest(atUrl url: URL,
                        usingMethod method: NetworkMethod,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkServiceDefault{
    let networkSession: NetworkSession
    init(networkSession:NetworkSession){
        self.networkSession = networkSession
    }
}

extension NetworkServiceDefault: NetworkService {
    enum Error: String, LocalizedError{
        case unknown = "Unknown error"
        case responseFormat = "Invalid response format"
        case statusCode = "Invalid status code"
        case data = "No data"
    }

    func performRequest(atUrl url: URL,
                        usingMethod method: NetworkMethod,
                        completion: @escaping (Result<Data, Swift.Error>) -> Void) {
        networkSession.dataTask(with: url) { (data, response, error) in

            if let error = error {
                completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(Error.responseFormat))
                return
            }
            if !(200..<300 ~= httpResponse.statusCode) {
                completion(.failure(Error.statusCode))
                return
            }
            guard let data = data else {
                completion(.failure(Error.data))
                return
            }
            completion(.success(data))

            }.resume()
    }
}
