
import Foundation
import Utils
@testable import Services

class APIRequestFactorySpy: APIRequestFactory {

    var createRequestResult: APIRequest

    init(createRequestResult: APIRequest) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIEndpoint]()

    func createRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        createRequestArgs.append(apiEndpoint)
        return createRequestResult
    }
}
