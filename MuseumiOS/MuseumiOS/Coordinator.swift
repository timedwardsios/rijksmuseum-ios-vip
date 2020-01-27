import UIKit
import MuseumKit

protocol Coordinator: PortfolioRouter {}

class CoordinatorDefault: Coordinator {
    func displayDetailsForArt(_ art: Art) {
        print(art.title)
    }
}
