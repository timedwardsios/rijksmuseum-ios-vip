
import Foundation
@testable import Utils

class NetworkResponseValidatorSpy: NetworkRawResponseValidator {

    var validateResponseAndUnwrapDataResult: Result<Data, Error>

    init(validateResponseAndUnwrapDataResult: Result<Data, Error>) {
        self.validateResponseAndUnwrapDataResult = validateResponseAndUnwrapDataResult
    }

    var validateResponseAndUnwrapDataArgs = [NetworkRawResponse]()

    func validateResponseAndUnwrapData(_ response: NetworkRawResponse) throws -> Data {
        validateResponseAndUnwrapDataArgs.append(response)
        return try validateResponseAndUnwrapDataResult.get()
    }
}
