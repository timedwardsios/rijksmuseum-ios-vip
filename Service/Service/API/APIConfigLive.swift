
import Foundation

struct APIConfigLive: APIConfig{
    let scheme = "https"
    let host = "www.rijksmuseum.nl"
    let path = "/api/en"
    let queryItems = [URLQueryItem(name : "key",
                                   value: "VV23OnI1"),
                      URLQueryItem(name: "format",
                                   value: "json")]
}
