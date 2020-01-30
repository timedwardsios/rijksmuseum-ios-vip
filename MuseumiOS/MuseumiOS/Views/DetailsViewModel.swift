import Foundation
import MuseumKit
import TimKit
import Combine

class DetailsViewModel {

    @Published var imageURL: URL

    init(imageURL: URL) {
        self.imageURL = imageURL
    }
}
