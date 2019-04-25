
import Foundation
import Utils
@testable import Service

class APIRequestFactorySpy: APIRequestFactory {

    var createRequestResult: Result<NetworkRequest, Error>

    init(createRequestResult: Result<NetworkRequest, Error>) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIEndpoint]()

    func createRequest(withEndpoint apiEndpoint: APIEndpoint) throws -> NetworkRequest {
        createRequestArgs.append(apiEndpoint)
        return try createRequestResult.get()
    }
}
