
import Foundation
import Service
import Utils

struct APIConfigLive:APIConfig{
    let scheme = "https"
    let hostname = "www.rijksmuseum.nl"
    let path = "/api/en"
    enum QueryItemName:String {
        case api = "key"
        case format = "format"
    }
    let queryItems = [URLQueryItem(name : QueryItemName.api.rawValue,
                                   value: "VV23OnI1"),
                      URLQueryItem(name: QueryItemName.format.rawValue,
                                   value: "json")]
}
