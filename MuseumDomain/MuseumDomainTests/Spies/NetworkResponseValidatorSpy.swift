import Foundation
import TestKit
@testable import Utils

class NetworkResponseValidatorSpy: APIResponseValidator {

    var validateResponseResult: Result<Data, Error> = .success(Seeds.data)

    var validateResponseArgs = [APIResponse]()

    func validateResponse(_ response: APIResponse) throws -> Data {

        validateResponseArgs.append(response)

        return try validateResponseResult.get()
    }
}
