import Foundation

struct ConfigDecodable: Decodable, Config {

    let apiBaseConfig: APIBaseConfig

    let apiRequestTemplates: APIRequestTemplates

    var apiQueryStringKeys: APIQueryStringKeys

    private enum CodingKeys: String, CodingKey {
        case apiBaseConfig
        case apiRequestTemplates
        case apiQueryStringKeys
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.apiBaseConfig = try container.decode(APIBaseConfigDecodable.self, forKey: .apiBaseConfig)
        self.apiRequestTemplates = try container.decode(APIRequestTemplatesDecodable.self, forKey: .apiRequestTemplates)
        self.apiQueryStringKeys = try container.decode(APIQueryStringKeysDecodable.self, forKey: .apiQueryStringKeys)
    }
}

struct APIBaseConfigDecodable: Decodable, APIBaseConfig {

    let scheme: String

    let host: String

    let path: String

    var queryItems: [String: String]
}

struct APIRequestTemplatesDecodable: Decodable, APIRequestTemplates {

    let search: APIRequest

    private enum CodingKeys: String, CodingKey {
        case search
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decode(APIRequestDecodable.self, forKey: .search)
    }
}

struct APIRequestDecodable: Decodable, APIRequest {

    let path: String

    let queryItems: [String: String]

    let method: String
}

struct APIQueryStringKeysDecodable: Decodable, APIQueryStringKeys {
    var searchTerm: String
}
