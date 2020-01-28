import Foundation
import MuseumKit
import TimKit
import Combine

protocol PortfolioViewModel {
//    var isLoading: Bool { get }
//    var alert: Alert? { get }
    var imageURLs: [URL] { get }

    func updateArts()
    func selectArt(atIndex index: Int)
}

class PortfolioViewModelDefault: PortfolioViewModel {

    lazy var publisher = CurrentValueSubject<PortfolioViewModel, Never>(self)

    // TODO: bind this to the global model.

    var imageURLs = [URL]() {
        didSet {
            publisher.send(self)
        }
    }

    var tokens = Set<AnyCancellable>()
}

extension PortfolioViewModelDefault {
    func updateArts() {
        FetchArt()
            .map { $0.map { $0.imageURL } }
            //                        .handleEvents(receiveCompletion: {
            //                            if case let (.failure(error)) = $0 {
            //                                self.view?.showAlert(.error(error.localizedDescription))
            //                            }
            //                        })

            // TODO: there must be a way to bind this to publisher.send
            .replaceError(with: [URL]())
            .assign(to: \.imageURLs, on: self).store(in: &tokens)
    }

    func selectArt(atIndex index: Int) {
        //        if let art = arts[optionalAt: index] {
        //            router.routeToArtDetails(forArt: art)
        //        }
    }
}
