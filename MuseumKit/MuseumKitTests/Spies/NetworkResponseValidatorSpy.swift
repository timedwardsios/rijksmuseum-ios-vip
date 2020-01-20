import Foundation
import TestKit
@testable import TimKit

class NetworkResponseValidatorSpy: NetworkResponseValidator {

    var validateResponseResult: Result<Data, Error> = .success(Seeds.data)

    var validateResponseArgs = [NetworkResponse]()

    func validateResponse(_ response: NetworkResponse) throws -> Data {

        validateResponseArgs.append(response)

        return try validateResponseResult.get()
    }
}
