import Foundation

protocol Config {

    var apiBaseConfig: APIBaseConfig {get}

    var apiRequestTemplates: APIRequestTemplates {get}

    var apiQueryStringKeys: APIQueryStringKeys {get}
}

protocol APIBaseConfig {

    var scheme: String {get}

    var host: String {get}

    var path: String {get}

    var queryItems: [String: String] {get}
}

protocol APIQueryStringKeys {
    var searchTerm: String {get}
}

protocol APIRequestTemplates {
    var search: APIRequest {get}
}
