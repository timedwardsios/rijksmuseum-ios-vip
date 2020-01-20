import Foundation
import TestKit
@testable import MuseumKit

struct ArtistMock: Artist, Equatable {
    var remoteId = Seeds.int
    var name = Seeds.string
}
