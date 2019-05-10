import Foundation
import TestTools
import TimKit
@testable import MuseumKit

struct NetworkRequestMock: NetworkRequest, Equatable {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
