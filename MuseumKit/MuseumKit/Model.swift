import Foundation
import TimKit

public class Model: ObservableObject {

    public init() {}

    @Published public var arts = [Art]()
}
