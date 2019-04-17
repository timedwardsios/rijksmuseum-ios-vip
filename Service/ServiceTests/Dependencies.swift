
import Foundation
@testable import Service

class DependenciesMock: Dependencies {}

protocol Dependencies: Service.Dependencies {
    func resolve() -> URLSessionDataTaskMock
}

extension Dependencies {
    public func resolve() -> ArtService {
        return ArtServiceMock()
    }

    func resolve() -> APIService {
        return APIServiceMock()
    }

    func resolve(dataTask: URLSessionDataTaskMock) -> APISessionMock {
        return APISessionMock(dataTask: dataTask)
    }

    func resolve() -> APIConfig {
        return APIConfigMock()
    }

    func resolve() -> URLSessionDataTaskMock {
        return URLSessionDataTaskMock()
    }
}
