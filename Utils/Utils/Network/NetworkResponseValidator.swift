
import Foundation

protocol NetworkResponse {
    var data: Data? {get}
    var urlResponse: URLResponse? {get}
    var error: Error? {get}
}

protocol NetworkResponseValidator {
    func validateResponseAndUnwrapData(_ response: NetworkResponse) throws -> Data
}

class NetworkResponseValidatorDefault{}

extension NetworkResponseValidatorDefault: NetworkResponseValidator {
    enum LocalError: String, LocalizedError{
        case noData = "No data"
        case invalidResponseFormat = "Invalid response format"
        case badStatusCode = "Invalid status code"
    }

    func validateResponseAndUnwrapData(_ response: NetworkResponse) throws -> Data {
        guard let data = response.data else {
            throw LocalError.noData
        }
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw LocalError.invalidResponseFormat
        }
        if !(200..<300 ~= httpResponse.statusCode) {
            throw LocalError.badStatusCode
        }
        if let error = response.error {
            throw error
        }
        return data
    }
}
