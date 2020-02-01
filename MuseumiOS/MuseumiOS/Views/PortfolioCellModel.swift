import Foundation
import MuseumKit

extension PortfolioCell {

    class Model: Identifiable {

        private let art: Art
        init(art: Art) {
            self.art = art
        }

        var imageURL: URL {
            art.imageURL
        }
    }
}
