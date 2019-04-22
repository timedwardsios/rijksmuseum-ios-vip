
import Foundation
@testable import Service

struct APIRequestMock: Service.APIRequest {
    let path = "/path"
    let queryItems = [URLQueryItem(name: "key",
                                   value: "value")]
}
