
import Foundation
import Utils
@testable import Kit

class APIRequestFactorySpy: APIRequestFactory {

    var createRequestResult: APIRequest

    init(createRequestResult: APIRequest) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIEndpoint]()

    func createAPIRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        createRequestArgs.append(apiEndpoint)
        return createRequestResult
    }
}
