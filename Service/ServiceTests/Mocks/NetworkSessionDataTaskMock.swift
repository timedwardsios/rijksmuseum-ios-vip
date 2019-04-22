
import Foundation
@testable import Service

class NetworkSessionDataTaskMock: NetworkSessionDataTask {

    var completion: (()->Void)?

    var resume_invocations = 0

    func resume() {
        resume_invocations += 1
        completion?()
    }
}
