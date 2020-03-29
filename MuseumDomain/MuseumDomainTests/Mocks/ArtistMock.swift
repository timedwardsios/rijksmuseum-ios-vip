import Foundation
@testable import MuseumDomain
import TestKit

struct ArtistMock: Artist, Equatable {
    var remoteId = Seeds.int
    var name = Seeds.string
}
