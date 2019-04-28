
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

    func validateResponse(_ rawResponse: NetworkRawResponse) throws -> Data {

        try checkErrorInResponse(rawResponse)

        try checkStatusCodeInResponse(rawResponse)

        let data = try unwrapDataFromResponse(rawResponse)

        return data
    }
}

private extension NetworkRawResponseValidatorDefault {

    func checkErrorInResponse(_ response: NetworkRawResponse) throws {
        if let error = response.error {
            throw error
        }
    }

    func checkStatusCodeInResponse(_ response: NetworkRawResponse) throws {
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw LocalError.invalidResponseFormat
        }
        if !(200..<300 ~= httpResponse.statusCode) {
            throw LocalError.badStatusCode
        }
    }

    func unwrapDataFromResponse(_ response: NetworkRawResponse) throws -> Data {
        guard let data = response.data else {
            throw LocalError.noData
        }
        return data
    }
}
