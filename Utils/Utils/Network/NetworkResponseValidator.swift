
import Foundation

// Performs requests
// Checks for errors

public protocol NetworkResponseValidator {
//    func validateResponse(_ response: NetworkResponse)
//    func processRequest(_ request: NetworkRequest,
//                        completion: @escaping (NetworkResponse) -> Void)
}

class NetworkResponseValidatorDefault{}

extension NetworkResponseValidatorDefault: NetworkResponseValidator {

    enum Error: String, LocalizedError{
        case unknown = "Unknown error"
        case responseFormat = "Invalid response format"
        case statusCode = "Invalid status code"
        case data = "No data"
    }

//    func processRequest(_ request: NetworkRequest, completion: @escaping (NetworkResponse) -> Void) {
//        networkSession.dataTask(with: request.url) { (data, response, error) in

//        }
//            if let error = error {
//                completion(.failure(error))
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(Error.responseFormat))
//                return
//            }
//            if !(200..<300 ~= httpResponse.statusCode) {
//                completion(.failure(Error.statusCode))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(Error.data))
//                return
//            }
//            completion(.success(data))
//
//            }.resume()
//    }

//    func performRequest(atUrl url: URL,
//                        usingMethod method: NetworkMethod,
//                        completion: @escaping (Result<Data, Swift.Error>) -> Void) {
//        networkSession.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                completion(.failure(error))
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(Error.responseFormat))
//                return
//            }
//            if !(200..<300 ~= httpResponse.statusCode) {
//                completion(.failure(Error.statusCode))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(Error.data))
//                return
//            }
//            completion(.success(data))
//
//            }.resume()
//    }
}
