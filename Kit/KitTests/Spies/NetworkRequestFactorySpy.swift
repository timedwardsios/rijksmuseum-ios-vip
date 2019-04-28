
import Foundation
import Utils
@testable import Kit

class NetworkRequestFactorySpy: NetworkRequestFactory {

    var createRequestResult: Result<NetworkRequest, Error>

    init(createRequestResult: Result<NetworkRequest, Error>) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIRequest]()

    func networkRequest(fromAPIRequest apiRequest:APIRequest) throws -> NetworkRequest {
        createRequestArgs.append(apiRequest)
        return try createRequestResult.get()
    }
}
