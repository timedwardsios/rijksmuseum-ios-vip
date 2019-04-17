import Foundation

protocol APIRequest {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
}
