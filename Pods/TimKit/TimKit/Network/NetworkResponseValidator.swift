import Foundation

public protocol NetworkResponse {

    var data: Data? {get}

    var urlResponse: URLResponse? {get}

    var error: Error? {get}
}

public enum NetworkResponseValidatorError: LocalizedError {

    case cancelled

    case rawResponseError(Error)

    case invalidResponseFormat

    case badStatusCode

    case noData
}

public protocol NetworkResponseValidator {
    func validateResponse(_ response: NetworkResponse) throws -> Data
}

class NetworkResponseValidatorDefault: NetworkResponseValidator {

    func validateResponse(_ response: NetworkResponse) throws -> Data {

        return try getDataResultFromResponse(response)
    }
}

private extension NetworkResponseValidatorDefault {

    func getDataResultFromResponse(_ response: NetworkResponse) throws -> Data {

        try checkErrorFromResponse(response)

        try checkStatusCodeFromResponse(response)

        return try unwrapDataFromResponse(response)
    }

    func checkErrorFromResponse(_ response: NetworkResponse) throws {

        if let error = response.error {

            if (error as NSError).code == NSURLErrorCancelled {
                throw NetworkResponseValidatorError.cancelled
            }

            throw NetworkResponseValidatorError.rawResponseError(error)
        }
    }

    func checkStatusCodeFromResponse(_ response: NetworkResponse) throws {

        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw NetworkResponseValidatorError.invalidResponseFormat
        }

        if !(200..<300 ~= httpResponse.statusCode) {
            throw NetworkResponseValidatorError.badStatusCode
        }
    }

    func unwrapDataFromResponse(_ response: NetworkResponse) throws -> Data {

        guard let data = response.data else {
            throw NetworkResponseValidatorError.noData
        }

        return data
    }
}
