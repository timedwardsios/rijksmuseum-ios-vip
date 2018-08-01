
import Foundation

protocol ArtPrimitive {
    var remoteId: String{get}
    var title: String{get}
    var artist: String{get}
    var imageUrl: URL{get}
}
