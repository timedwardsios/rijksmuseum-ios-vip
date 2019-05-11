import Foundation

public protocol ConfigService {
    func getConfig<T: Decodable>(forBundle bundle: Bundle) -> T
}

class ConfigServiceDefault {

    private let configFileName = "config.plist"

    let propertyListDecoderService: PropertyListDecoder
    let fileManager: FileManager

    init(fileManager: FileManager,
         propertyListDecoderService: PropertyListDecoder) {
        self.propertyListDecoderService = propertyListDecoderService
        self.fileManager = fileManager
    }
}

extension ConfigServiceDefault: ConfigService {

    func getConfig<T>(forBundle bundle: Bundle) -> T where T: Decodable {
        let configURL = bundle.url(forResource: configFileName, withExtension: nil)!
        let data = try! Data(contentsOf: configURL)

        let config = try! propertyListDecoderService.decode(T.self, from: data)
        return config
    }
}
