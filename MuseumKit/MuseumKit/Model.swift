import Foundation
import TimKit

public protocol Art {
    var id: String { get }
    var title: String { get }
    var artist: String { get }
    var imageURL: URL { get }
}

public class Model: ObservableObject {

    public init() {}

    @Published public var arts = [Art]()
}
