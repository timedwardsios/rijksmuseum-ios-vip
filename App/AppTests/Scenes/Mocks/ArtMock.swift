
import Foundation
import UtilsTestTools
@testable import Services

struct ArtMock: Art, Equatable {
    var id = Seeds.string
    var title = Seeds.string
    var artist = Seeds.string
    var imageUrl = Seeds.url
}
