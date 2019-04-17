
import Foundation
@testable import Service

struct APIConfigMock: APIConfig{
    let scheme:String = "https"
    let hostname = "hostname.com"
    let path = "/path/to/api"
    let queryItems = [URLQueryItem(name : "configKey",
                                   value: "configValue")]
}
