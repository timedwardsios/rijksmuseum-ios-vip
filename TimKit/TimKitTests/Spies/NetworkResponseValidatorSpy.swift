import Foundation
@testable import TimKit

class NetworkResponseValidatorSpy: NetworkRawResponseValidator {

    var validateResponseResult: Result<Data, Error>

    init(validateResponseAndUnwrapDataResult: Result<Data, Error>) {
        self.validateResponseResult = validateResponseAndUnwrapDataResult
    }

    var validateResponseArgs = [NetworkRawResponse]()

    func validateResponse(_ response: NetworkRawResponse) -> Result<Data, Error> {
        validateResponseArgs.append(response)
        return validateResponseResult
    }
}
