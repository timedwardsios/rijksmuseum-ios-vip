import Combine
import Foundation
import Utils

public protocol Art {
    var id: String { get }

    var title: String { get }

    var artist: String { get }

    var imageURL: URL { get }
}
