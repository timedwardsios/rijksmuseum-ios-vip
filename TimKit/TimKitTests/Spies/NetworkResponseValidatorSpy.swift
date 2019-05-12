import Foundation
@testable import TimKit

class NetworkResponseValidatorSpy: NetworkRawResponseValidator {

    var validateResponseResult: Result<Data, Error>

    init(validateResponseResult: Result<Data, Error>) {
        self.validateResponseResult = validateResponseResult
    }

    var validateResponseArgs = [NetworkRawResponse]()

    func validateResponse(_ response: NetworkRawResponse) -> Result<Data, Error> {
        validateResponseArgs.append(response)
        return validateResponseResult
    }
}
