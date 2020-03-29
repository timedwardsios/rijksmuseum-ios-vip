import UIKit

public struct Alert {
    public typealias Handler = () -> Void
    let title: String
    let message: String
    let okHandler: Handler?
}

public extension Alert {
    static func generic(_ message: String, okHandler: Handler? = nil) -> Self {
        .init(title: "Alert", message: message, okHandler: okHandler)
    }

    static func error(_ error: Error, okHandler: Handler? = nil) -> Self {
        .init(title: "Error", message: error.localizedDescription, okHandler: okHandler)
    }
}
