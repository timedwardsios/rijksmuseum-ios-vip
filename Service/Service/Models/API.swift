
import Foundation

public protocol APIRequestProtocol {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
}

public protocol APIConfigProtocol:APIRequestProtocol {
    var scheme:String {get}
    var hostname:String {get}
}

public protocol APISessionProtocol {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletion)-> URLSessionDataTask
}
extension URLSession:APISessionProtocol{}
