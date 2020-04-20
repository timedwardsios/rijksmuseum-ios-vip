import Foundation
@testable import Utils

class NetworkSessionDataTaskSpy: TimKit.URLSessionDataTask {
    var completion: (() -> Void)?

    var resumeArgs = 0

    var cancelArgs = 0

    func resume() {
        resumeArgs += 1
        completion?()
    }

    func cancel() {
        cancelArgs += 1
    }
}
