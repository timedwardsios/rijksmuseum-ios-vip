import Foundation
import TestKit
import MuseumKit

struct ArtMock: Art, Equatable {
    var identifier = Seeds.string
    var title = Seeds.string
    var artist = Seeds.string
    var imageURL = Seeds.url
}
