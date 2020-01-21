import Foundation
@testable import TimKit

class NetworkSessionDataTaskSpy: TimKit.APISessionDataTask {

    var completion: (() -> Void)?

    var resumeArgs = 0
    func resume() {
        resumeArgs += 1
        completion?()
    }

    var cancelArgs = 0
    func cancel() {
        cancelArgs += 1
    }
}
