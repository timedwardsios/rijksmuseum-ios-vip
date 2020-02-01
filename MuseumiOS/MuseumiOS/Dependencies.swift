import UIKit
import MuseumKit
import Combine

let dependencies = Dependencies()

struct Dependencies {
    
    //    static let coordinator = CoordinatorDefault()
    
    func resolve() -> PortfolioView {
        let viewModel = PortfolioViewModel(state: MuseumKit.dependencies.resolve(),
                                           artInteractor: MuseumKit.dependencies.resolve())
        return Self.storyboard.instantiateViewController(identifier: PortfolioView.reuseIdentifier) {
            PortfolioView(coder: $0, viewModel: viewModel)
        }
    }
    
    func resolve(imageURL: URL) -> DetailsView {
        let viewModel = DetailsView.Model(imageURL: imageURL)
        return Self.storyboard.instantiateViewController(identifier: DetailsView.reuseIdentifier) {
            DetailsView(coder: $0, viewModel: viewModel)
        }
    }
    
    static let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}
