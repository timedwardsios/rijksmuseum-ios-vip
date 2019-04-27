
import UIKit

public protocol StoryboardLoadable {}

public extension StoryboardLoadable where Self: UIViewController {
    static func fromStoryboard(_ storyboard: UIStoryboard) -> Self {
        let typeName = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: typeName) as! Self
    }
}
