import Foundation
import TimKit
import Combine

public protocol Art {
    var id: String { get }
    var title: String { get }
    var artist: String { get }
    var imageURL: URL { get }
}

public class State {
    @Published public var arts = [Art]() {
        didSet {
            
        }
    }
}
