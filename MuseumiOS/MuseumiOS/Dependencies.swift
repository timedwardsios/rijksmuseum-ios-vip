import UIKit
import MuseumKit

let dependencies = Dependencies()

struct Dependencies {

    static let coordinator = CoordinatorDefault()

    func resolve() -> PortfolioRouter { Self.coordinator }

    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artController: MuseumKit.dependencies.resolve(),
                                             router: resolve(),
                                             model: MuseumKit.dependencies.resolve())
        let viewController = Self.storyboard.instantiateViewController(identifier: PortfolioViewController.id) {
            PortfolioViewController(coder: $0, interactor: interactor)
        }
        presenter.display = viewController
        return viewController
    }

    func resolve(art: Art) -> DetailsViewController {
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor(presenter: presenter,
                                           art: art)
        let viewController = Self.storyboard.instantiateViewController(identifier: DetailsViewController.id) {
            DetailsViewController(coder: $0, interactor: interactor)
        }
        presenter.display = viewController
        return viewController
    }

    static let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}
