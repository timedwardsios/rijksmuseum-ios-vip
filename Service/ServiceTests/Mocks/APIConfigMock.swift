
import Foundation
import Utils
@testable import Service

class APIConfigMock: APIConfig {
    
    var path: String
    var queryItems: [URLQueryItem]
    var scheme: String
    var host: String

    init(path: String,
         queryItems: [URLQueryItem],
         scheme: String,
         host: String) {
        self.path = path
        self.queryItems = queryItems
        self.scheme = scheme
        self.host = host
    }
}
