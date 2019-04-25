
import Foundation
import Utils
@testable import Service

internal class APIConfigSeed: APIConfig{
    var scheme = "https"
    var host = Seeds.string
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}

internal class APIEndpointSeed: APIEndpoint{
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}

internal enum Seeds: Seedable {}

internal extension Seedable {
    static var apiConfig: APIConfigSeed {
        return APIConfigSeed()
    }

    static var apiEndpoint: APIEndpointSeed {
        return APIEndpointSeed()
    }
}
