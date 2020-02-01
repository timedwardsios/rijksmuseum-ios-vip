import Foundation
import MuseumKit
import TimKit
import Combine

extension DetailsView {
    class Model {

        @Published var imageURL: URL

        init(imageURL: URL) {
            self.imageURL = imageURL
        }
    }
}
