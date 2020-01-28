import Foundation
import MuseumKit
import TimKit
import Combine

class PortfolioViewModel {

    @Published private(set) var isFetching = false
    @Published private(set) var imageURLs = [URL]()
    @Published private(set) var alert: Alert?

    private var tokens = Set<AnyCancellable>()

    private let artController: ArtController

    init(artController: ArtController,
         model: Model) {
        self.artController = artController

        model.$arts
            .map { $0.map { $0.imageURL } }
            .assign(to: \.imageURLs, on: self)
            .store(in: &tokens)
    }
}

// TODO: Error alerts
extension PortfolioViewModel {
    func updateArts() {
        artController
            .updateArt()
            .assertNoFailure()
            .assign(to: \.isFetching, on: self)
            .store(in: &tokens)
    }

    func selectArt(atIndex index: Int) {
        //        if let art = arts[optionalAt: index] {
        //            router.routeToArtDetails(forArt: art)
        //        }
    }
}
