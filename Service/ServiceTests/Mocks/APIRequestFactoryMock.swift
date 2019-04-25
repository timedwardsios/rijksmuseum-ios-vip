
import Foundation
import Utils
@testable import Service

class APIRequestFactoryMock: APIRequestFactory {

    var createRequestReturnValue: Result<NetworkRequest, Error>

    init(createRequestReturnValue: Result<NetworkRequest, Error>) {
        self.createRequestReturnValue = createRequestReturnValue
    }

    var createRequestArgs = [APIEndpoint]()

    func createRequest(withEndpoint apiEndpoint: APIEndpoint) throws -> NetworkRequest {
        createRequestArgs.append(apiEndpoint)
        return try createRequestReturnValue.get()
    }
}
