
import Foundation
import Utils
@testable import Services

class APIRequestMock: APIRequest {

    var path: String
    var queryItems: [URLQueryItem]

    init(path: String,
         queryItems: [URLQueryItem]) {
        self.path = path
        self.queryItems = queryItems
    }
}
