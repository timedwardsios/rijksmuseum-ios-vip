import Foundation

protocol APIConfig {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
    var scheme:String {get}
    var hostname:String {get}
}

struct APIConfigDefault:APIConfig{
    let scheme = "https"
    let hostname = "www.rijksmuseum.nl"
    let path = "/api/en"
    let queryItems = [URLQueryItem(name : "key",
                                   value: "VV23OnI1"),
                      URLQueryItem(name: "format",
                                   value: "json")]
}
