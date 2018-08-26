
import Foundation

public protocol APIRequest {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
}

public protocol APIConfig:APIRequest {
    var scheme:String {get}
    var hostname:String {get}
}

public protocol APISession {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletion)-> URLSessionDataTask
}
extension URLSession:APISession{}
