import Foundation
import TimKit
@testable import MuseumKit

class APIRequestFactorySpy: APIRequestFactory {

    var constructAPIRequestResult = APIRequestMock()

    var constructAPIRequestArgs = [APIOperation]()

    func constructAPIRequest(fromOperation operation: APIOperation) -> APIRequest {
        constructAPIRequestArgs.append(operation)
        return constructAPIRequestResult
    }
}
