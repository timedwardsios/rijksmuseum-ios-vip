
import Foundation
@testable import Service

struct APIRequestMock: Service.APIRequest {
    let path: String
    let queryItems: [URLQueryItem]
    init(path: String,
         queryItems: [URLQueryItem]) {
        self.path = path
        self.queryItems = queryItems
    }
}
