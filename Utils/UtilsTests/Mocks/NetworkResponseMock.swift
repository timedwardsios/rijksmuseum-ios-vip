import Foundation
import TestTools
@testable import Utils

struct NetworkResponseMock: NetworkRawResponse {
    var data: Data? = Seeds.data
    var urlResponse: URLResponse? = Seeds.urlResponse
    var error: Error?
}
