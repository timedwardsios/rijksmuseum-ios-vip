import Foundation
import TestTools
@testable import MuseumKit

struct APIRequestMock: APIRequest, Equatable {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
}
