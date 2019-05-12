import Foundation

enum NetworkRawResponseValidatorError: String, LocalizedError {
    case noData = "No data"
    case invalidResponseFormat = "Invalid response format"
    case badStatusCode = "Invalid status code"
}

protocol NetworkRawResponse {
    var data: Data? {get}
    var urlResponse: URLResponse? {get}
    var error: Error? {get}
}

protocol NetworkRawResponseValidator {
    func validateResponse(_ response: NetworkRawResponse) -> Result<Data, Error>
}

class NetworkRawResponseValidatorDefault: NetworkRawResponseValidator {
    func validateResponse(_ response: NetworkRawResponse) -> Result<Data, Error> {
        return getDataResultFromResponse(response)
    }
}

private extension NetworkRawResponseValidatorDefault {

    func getDataResultFromResponse(_ response: NetworkRawResponse) -> Result<Data, Error> {
        return Result {
            try checkErrorInResponse(response)

            try checkStatusCodeInResponse(response)

            return try unwrapDataFromResponse(response)
        }
    }

    func checkErrorInResponse(_ response: NetworkRawResponse) throws {
        if let error = response.error {
            throw error
        }
    }

    func checkStatusCodeInResponse(_ response: NetworkRawResponse) throws {
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw NetworkRawResponseValidatorError.invalidResponseFormat
        }
        if !(200..<300 ~= httpResponse.statusCode) {
            throw NetworkRawResponseValidatorError.badStatusCode
        }
    }

    func unwrapDataFromResponse(_ response: NetworkRawResponse) throws -> Data {
        guard let data = response.data else {
            throw NetworkRawResponseValidatorError.noData
        }
        return data
    }
}
