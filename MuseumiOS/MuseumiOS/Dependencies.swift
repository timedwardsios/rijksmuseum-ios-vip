import UIKit
import MuseumKit
import Combine

let dependencies = Dependencies()

struct Dependencies {

    //    static let coordinator = CoordinatorDefault()

    func resolve() -> PortfolioViewController {
        let viewModel = PortfolioViewModel(artController: MuseumKit.dependencies.resolve())
        return Self.storyboard.instantiateViewController(identifier: PortfolioViewController.reuseIdentifier) {
            PortfolioViewController(coder: $0, viewModel: viewModel)
        }
    }

    func resolve(imageURL: URL) -> DetailsViewController {
        let viewModel = DetailsViewModel(imageURL: imageURL)
        return Self.storyboard.instantiateViewController(identifier: DetailsViewController.reuseIdentifier) {
            DetailsViewController(coder: $0, viewModel: viewModel)
        }
    }

    static let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}
