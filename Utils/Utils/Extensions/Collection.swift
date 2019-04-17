
import Foundation

// Can now use safe: on array subscript to safely return optional

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
