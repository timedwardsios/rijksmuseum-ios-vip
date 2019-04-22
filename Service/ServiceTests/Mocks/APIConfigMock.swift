
import Foundation
@testable import Service

struct APIConfigMock: APIConfig{
    let scheme:String = "https"
    let hostname = "hostname.com"
    let path = "/path"
    let queryItems = [URLQueryItem(name : "key",
                                   value: "value")]
}
