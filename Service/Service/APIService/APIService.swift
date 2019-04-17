
import Foundation

enum APIServiceError: String, LocalizedError{
    case responseFormat = "Invalid response format"
    case statusCode = "Invalid status code"
    case data = "No data"
}

protocol APIService {
    func performGet(request: APIRequest,
                    completion: @escaping (Result<Data, Error>) -> Void)
}
