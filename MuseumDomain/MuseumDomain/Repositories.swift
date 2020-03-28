import Foundation
import Utils

public struct Services {

    public let webService: WebService

    public init() {
        self.webService = WebServiceDefault.init(webSession: URLSession.shared, jsonDecoder: .init())
    }
}
