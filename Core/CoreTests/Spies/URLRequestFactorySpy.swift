import Foundation
@testable import MuseumCore
import TestKit

class URLRequestFactorySpy: URLRequestFactory {
    var constructURLRequestFromAPIRequestResult: Result<URLRequest, URLRequestFactoryError> =
        .success(URLRequest(url: Seeds.url))

    var constructURLRequestFromAPIRequestArgs = [APIRequest]()

    func constructURLRequestFromAPIRequest(_ apiRequest: APIRequest) throws -> URLRequest {
        constructURLRequestFromAPIRequestArgs.append(apiRequest)

        return try constructURLRequestFromAPIRequestResult.get()
    }
}
