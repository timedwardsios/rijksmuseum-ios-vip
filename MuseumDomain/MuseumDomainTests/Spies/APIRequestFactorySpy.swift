import Foundation
import Utils
@testable import MuseumDomain

class APIRequestFactorySpy: APIRequestFactory {

    var constructAPIRequestResult = APIRequestMock()

    var constructAPIRequestArgs = [APIOperation]()

    func constructAPIRequest(fromOperation operation: APIOperation) -> APIRequest {
        constructAPIRequestArgs.append(operation)
        return constructAPIRequestResult
    }
}
