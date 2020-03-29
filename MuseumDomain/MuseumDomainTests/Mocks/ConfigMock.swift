import Foundation
@testable import MuseumDomain
import TestKit

struct APIBaseConfigMock: APIBaseConfig {
    var scheme = "https"
    var host = Seeds.string
    var path = "/" + Seeds.string
    var queryItems = [Seeds.string: Seeds.string]
}

struct APIRequestMock: APIRequest, Equatable {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.string: Seeds.string]
    var method = "GET"
}

struct APIRequestTemplatesMock: APIRequestTemplates {
    var search: APIRequest = APIRequestMock()
}

struct APIQueryStringKeysMock: APIQueryStringKeys {
    var searchTerm: String = Seeds.string
}

struct ConfigMock: Config {
    var apiBaseConfig: APIBaseConfig = APIBaseConfigMock()
    var apiRequestTemplates: APIRequestTemplates = APIRequestTemplatesMock()
    var apiQueryStringKeys: APIQueryStringKeys
}
