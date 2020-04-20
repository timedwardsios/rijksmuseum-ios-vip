import Foundation
@testable import MuseumCore
import TestKit

struct ArtistMock: Artist, Equatable {
    var remoteId = Seeds.int
    var name = Seeds.string
}
