
import Foundation

internal protocol NetworkRawResponse {
    var data: Data? {get}
    var urlResponse: URLResponse? {get}
    var error: Error? {get}
}

internal protocol NetworkRawResponseValidator {
    func validateResponse(_ response: NetworkRawResponse) throws -> Data
}

private enum LocalError: String, LocalizedError {
    case noData = "No data"
    case invalidResponseFormat = "Invalid response format"
    case badStatusCode = "Invalid status code"
}

internal class NetworkRawResponseValidatorDefault{}

extension NetworkRawResponseValidatorDefault: NetworkRawResponseValidator {

    func validateResponse(_ response: NetworkRawResponse) throws -> Data {
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
