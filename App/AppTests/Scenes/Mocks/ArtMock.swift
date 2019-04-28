
import Foundation
import TestTools
@testable import Kit

struct ArtMock: Art, Equatable {
    var id = Seeds.string
    var title = Seeds.string
    var artist = Seeds.string
    var imageURL = Seeds.url
}
