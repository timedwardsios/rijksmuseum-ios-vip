import UIKit

public struct Alert {
    public typealias Handler = () -> Void
    let title: String
    let message: String
    let okHandler: Handler?
}

extension Alert {

    public static func generic(_ message: String, okHandler: Handler? = nil) -> Self {
        .init(title: "Alert", message: message, okHandler: okHandler)
    }

    public static func error(_ error: Error, okHandler: Handler? = nil) -> Self {
        .init(title: "Error", message: error.localizedDescription, okHandler: okHandler)
    }
}
