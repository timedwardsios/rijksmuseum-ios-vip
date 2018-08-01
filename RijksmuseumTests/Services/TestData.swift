
import Foundation
@testable import Rijksmuseum

struct TestData{
    struct ArtPrimitiveMock:ArtPrimitive{
        var remoteId = "mock remoteId"
        var title = "mock title"
        var artist = "mock artist"
        var imageUrl = URL(string: "http://www.apple.com")!
    }
}
