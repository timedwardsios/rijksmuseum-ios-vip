import Foundation
import TimKit

enum APIOperation {

    case search(term: String)
}

private struct APIRequestDefault: APIRequest {

    let path: String

    let queryItems: [String: String]

    let method: String
}

protocol APIRequestFactory {
    func constructAPIRequest(fromOperation operation: APIOperation) -> APIRequest
}

class APIRequestFactoryDefault {

    let apiRequestTemplates: APIRequestTemplates
    let apiQueryStringKeys: APIQueryStringKeys
    init(apiRequestTemplates: APIRequestTemplates,
         apiQueryStringKeys: APIQueryStringKeys) {
        self.apiRequestTemplates = apiRequestTemplates
        self.apiQueryStringKeys = apiQueryStringKeys
    }
}

extension APIRequestFactoryDefault: APIRequestFactory {
    func constructAPIRequest(fromOperation operation: APIOperation) -> APIRequest {

        switch operation {
        case .search(let term):

            let template = apiRequestTemplates.search

            var queryItems = template.queryItems

            let searchTermQueryStringKey = apiQueryStringKeys.searchTerm

            queryItems[searchTermQueryStringKey] = term

            let request = APIRequestDefault(path: template.path, queryItems: queryItems, method: template.method)

            return request
        }
    }
}
