
import Service

typealias Assembler = PortfolioAssembler & ServiceAssembler

class AssemblerDefault: Assembler {}

protocol PortfolioAssembler {
    func resolve() -> PortfolioViewController
    func resolve(presenter: PortfolioPresenter) -> PortfolioInteractor
    func resolve() -> PortfolioPresenter
}

extension PortfolioAssembler where Self: Assembler {
    func resolve() -> PortfolioViewController {
        let presenter: PortfolioPresenter = resolve()
        let interactor: PortfolioInteractor = resolve(presenter: presenter)
        let vc = PortfolioViewController(interactor: interactor)
        presenter.view = vc
        return vc
    }

    func resolve(presenter: PortfolioPresenter) -> PortfolioInteractor {
        return PortfolioInteractor(presenter: presenter, artService: resolve())
    }

    func resolve() -> PortfolioPresenter {
        return PortfolioPresenter()
    }
}
