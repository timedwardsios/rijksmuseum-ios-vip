import Foundation
import TestKit
@testable import Utils

struct NetworkResponseMock: APIResponse {
    var data: Data? = Seeds.data

    var urlResponse: URLResponse? = Seeds.urlResponse

    var error: Error?
}
