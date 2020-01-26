import Foundation
import TimKit

public class Model: ObservableObject, HasArts {

    public init() {}

    @Published public var arts = [Art]()
}
