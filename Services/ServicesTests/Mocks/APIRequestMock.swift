
import Foundation
import TestTools
@testable import Services

struct APIRequestMock: APIRequest, Equatable {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}
