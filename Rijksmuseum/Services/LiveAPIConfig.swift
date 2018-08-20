
import Foundation

struct LiveAPIConfig:APIConfig{
    let scheme = "https"
    let hostname = "www.rijksmuseum.nl"
    let path = "/api/en"
    enum QueryItemName:String {
        case apiKey = "key"
        case format = "format"
    }
    let queryItems = [URLQueryItem(name : QueryItemName.apiKey.rawValue,
                                   value: "VV23OnI1"),
                      URLQueryItem(name: QueryItemName.format.rawValue,
                                   value: "json")]
}
