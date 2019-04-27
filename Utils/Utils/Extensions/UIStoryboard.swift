
import UIKit

public extension UIStoryboard {
    static var main: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()

    func instantiateViewController<T: UIViewController>(forType type: T.Type) -> T? {
        let typeName = String(describing: type)
        return self.instantiateViewController(withIdentifier: typeName) as? T
    }
}
