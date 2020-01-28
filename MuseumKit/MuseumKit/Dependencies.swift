import Foundation
import TimKit
import Combine

public let dependencies = Dependencies()

public struct Dependencies {

    private let _model = Model()
    public func resolve() -> Model { _model }

    func resolve() -> APIConfig { APIConfigDefault() }
}
