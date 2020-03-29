@testable import MuseumDomain
import Foundation
import TestKit

struct ArtistMock: Artist, Equatable {
    var remoteId = Seeds.int
    var name = Seeds.string
}
