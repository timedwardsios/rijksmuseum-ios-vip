import Foundation

struct Config: Decodable {
    var apiBaseConfig: APIBaseConfig
    var apiRequestConfig: APIRequestConfig
}

struct APIBaseConfig: Decodable {
    var scheme: String
    var host: String
    var path: String
    var queryItems: [String: String]
}

struct APIRequest: Decodable {
    let path: String
    var queryItems: [String: String]
}

struct APIRequestConfig: Decodable {
    let collection: APIRequest
}
