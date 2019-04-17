
import Foundation
@testable import Service

class URLSessionDataTaskMock: URLSessionDataTask{

    let data = UUID().uuidString.data(using: .utf8)
//    var validResponseFormat = true
//    var includeData = true
//    var statusCode = 200

    override func resume() {
        super.resume()
//        let response = HTTPURLResponse(url: url,
//                                       statusCode: statusCode,
//                                       httpVersion: nil,
//                                       headerFields: nil)!
//        completion(includeData ? data : nil, validResponseFormat ? response : URLResponse(), nil)
    }
}
