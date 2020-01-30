import UIKit

public protocol ViewModelSettable {
    associatedtype VM: Identifiable
    func setViewModel(_ viewModel: VM)
}
