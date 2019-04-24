
import Foundation
import Utils
@testable import Service

protocol Seedable: Utils.Seedable {}

class APIConfigSeed: APIConfig{
    var scheme = "https"
    var hostname = Seeds.string
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}

class APIEndpointSeed: APIEndpoint{
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}

enum Seeds: Seedable{

    static var apiConfig: APIConfigSeed {
        return APIConfigSeed()
    }

    static var apiEndpoint: APIEndpointSeed {
        return APIEndpointSeed()
    }
}
