
import Foundation

public extension Collection {
    subscript (optionalAt index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
