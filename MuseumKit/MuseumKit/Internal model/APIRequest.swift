import Foundation

protocol APIRequest {

    var path: String {get}

    var queryItems: [String: String] {get}

    var method: String {get}
}
