
import Foundation
import Utils
@testable import Service

class NetworkRequestFactorySpy: NetworkRequestFactory {

    var createRequestResult: Result<NetworkRequest, Error>

    init(createRequestResult: Result<NetworkRequest, Error>) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIRequest]()

    func createRequest(fromAPIRequest apiRequest:APIRequest) throws -> NetworkRequest {
        createRequestArgs.append(apiRequest)
        return try createRequestResult.get()
    }
}
