
import Foundation
@testable import Rijksmuseum

struct SharedMockData{
    struct ArtPrimitiveMock:ArtPrimitive{
        var remoteId = "mock remoteId"
        var title = "mock title"
        var artist = "mock artist"
        var imageUrl = URL(string: "http://www.apple.com")!
    }

    struct ErrorMock:Error {}
}
