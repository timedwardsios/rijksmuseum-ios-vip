import Foundation
import TimKit
@testable import MuseumKit

class APIRequestFactorySpy: APIRequestFactory {

    var createRequestResult: APIRequest

    init(createRequestResult: APIRequest) {
        self.createRequestResult = createRequestResult
    }

    var createRequestArgs = [APIEndpoint]()

    func apiRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        createRequestArgs.append(apiEndpoint)
        return createRequestResult
    }
}
