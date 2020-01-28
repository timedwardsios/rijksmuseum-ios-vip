import UIKit
import MuseumKit
import Combine

let dependencies = Dependencies()

struct Dependencies {

    //    static let coordinator = CoordinatorDefault()

    func resolve() -> PortfolioViewController {

        let viewModel = PortfolioViewModelDefault()

        let viewController = Self.storyboard.instantiateViewController(
            identifier: PortfolioViewController.id
        ) {
            PortfolioViewController(
                coder: $0,
                viewModelPublisher: viewModel.publisher
            )
        }

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
