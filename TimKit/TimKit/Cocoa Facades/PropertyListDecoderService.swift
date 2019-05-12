import Foundation

public protocol PropertyListDecoderService {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension PropertyListDecoder: PropertyListDecoderService {}
