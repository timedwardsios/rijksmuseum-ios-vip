
import Foundation
import UtilsTestTools
@testable import Services

class APIRequestMock: APIRequest {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}
