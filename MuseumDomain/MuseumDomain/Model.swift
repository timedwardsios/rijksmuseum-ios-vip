import Foundation
import Utils
import Combine

public protocol StringIdentifiable {
    var id: String { get }
}

public protocol ArtMetadata {
    var title: String { get }
    var artist: String { get }
}

public protocol RemoteImage{
    var imageURL: URL { get }
}

public protocol Art: StringIdentifiable, ArtMetadata, RemoteImage {}
