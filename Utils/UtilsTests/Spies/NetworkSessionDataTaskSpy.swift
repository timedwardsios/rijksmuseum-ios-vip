
import Foundation
@testable import Utils

class NetworkSessionDataTaskSpy: Utils.NetworkSessionDataTask {

    var completion: (()->Void)?

    var resumeArgs = 0

    func resume() {
        resumeArgs += 1
        completion?()
    }
}
