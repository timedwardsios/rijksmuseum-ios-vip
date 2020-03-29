import Foundation
import MuseumKit
import TestKit

struct ArtMock: Art, Equatable {
    var id = Seeds.string
    var title = Seeds.string
    var artist = Seeds.string
    var imageURL = Seeds.url
}
