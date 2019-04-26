
import Foundation
import UtilsTestTools
@testable import Utils

class NetworkResponseMock: NetworkResponse {
    var data: Data? = Seeds.data
    var urlResponse: URLResponse? = Seeds.urlResponse
    var error: Error? = nil
}
