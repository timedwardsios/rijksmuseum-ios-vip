import Foundation

public protocol JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension Foundation.JSONDecoder: JSONDecoder {}
