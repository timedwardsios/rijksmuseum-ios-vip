
import Foundation
@testable import Utils

class URLSessionDataTaskSpy: Utils.URLSessionDataTask {

    var completion: (()->Void)?

    var resumeArgs = 0

    func resume() {
        resumeArgs += 1
        completion?()
    }
}
