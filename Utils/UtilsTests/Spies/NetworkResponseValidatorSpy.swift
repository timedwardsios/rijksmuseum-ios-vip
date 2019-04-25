
import Foundation
@testable import Utils

class NetworkResponseValidatorSpy: NetworkResponseValidator {

    var validateResponseAndUnwrapDataResult: Result<Data, Error>

    init(validateResponseAndUnwrapDataResult: Result<Data, Error>) {
        self.validateResponseAndUnwrapDataResult = validateResponseAndUnwrapDataResult
    }

    var validateResponseAndUnwrapDataArgs = [NetworkResponse]()

    func validateResponseAndUnwrapData(_ response: NetworkResponse) throws -> Data {
        validateResponseAndUnwrapDataArgs.append(response)
        return try validateResponseAndUnwrapDataResult.get()
    }
}
