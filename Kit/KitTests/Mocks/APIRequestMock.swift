import Foundation
import TestTools
@testable import Kit

struct APIRequestMock: APIRequest, Equatable {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}
