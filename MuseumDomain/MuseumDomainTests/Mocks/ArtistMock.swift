import Foundation
import TestKit
@testable import MuseumDomain

struct ArtistMock: Artist, Equatable {
    var remoteId = Seeds.int
    var name = Seeds.string
}
