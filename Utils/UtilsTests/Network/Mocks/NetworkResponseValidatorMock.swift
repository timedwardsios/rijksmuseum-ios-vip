
import Foundation
@testable import Utils

class NetworkResponseValidatorMock: NetworkResponseValidator {

    var resultToReturn: Result<Data, Error>

    init(resultToReturn: Result<Data, Error>) {
        self.resultToReturn = resultToReturn
    }

    var validateResponseAndUnwrapDataArgs = [NetworkResponse]()

    func validateResponseAndUnwrapData(_ response: NetworkResponse) throws -> Data {
        validateResponseAndUnwrapDataArgs.append(response)
        return try resultToReturn.get()
    }
}
