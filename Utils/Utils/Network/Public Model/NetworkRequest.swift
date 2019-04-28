import Foundation

public protocol NetworkRequest {
    var url: URL {get}
    var method: NetworkMethod {get}
}
