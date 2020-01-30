import Foundation
import TimKit
import Combine

public protocol StringIdentifiable {
    var id: String { get }
}

public protocol RemoteImage {
    var imageURL: URL { get }
}

public protocol Art: StringIdentifiable, RemoteImage {
    var title: String { get }
    var artist: String { get }
}

public class Model {
    @Published public var arts = [Art]()
}
