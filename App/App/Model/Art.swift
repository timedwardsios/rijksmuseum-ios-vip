
import Foundation

protocol Art {
    var remoteId: String{get}
    var title: String{get}
    var artist: String{get}
    var imageUrl: URL{get}
}

protocol ArtDetails {
    var subtitle: String{get}
    var description: String{get}
}
