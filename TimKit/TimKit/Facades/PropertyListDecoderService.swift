import Foundation

public protocol PropertyListDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension Foundation.PropertyListDecoder: PropertyListDecoder {}
