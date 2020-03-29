import Foundation
@testable import MuseumDomain
import Utils

class APIRequestFactorySpy: APIRequestFactory {
    var constructAPIRequestResult = APIRequestMock()

    var constructAPIRequestArgs = [APIOperation]()

    func constructAPIRequest(fromOperation operation: APIOperation) -> APIRequest {
        constructAPIRequestArgs.append(operation)
        return constructAPIRequestResult
    }
}
