import Foundation
import TimKit

protocol APIBaseConfig {
    var scheme: String {get}
    var host: String {get}
    var path: String {get}
    var queryItems: [String: String] {get}
}




protocol Config {
    var apiBase: APIBaseConfig {get}
}







protocol ConfigFactory {
    func getConfig() -> Config
}

class ConfigFactoryDefault {

    let jsonDecoderService: JSONDecoderService
    let fileManager: FileManager

    init(jsonDecoderService: JSONDecoderService,
         fileManager: FileManager) {
        self.jsonDecoderService = jsonDecoderService
        self.fileManager = fileManager
    }
}

extension ConfigFactoryDefault: ConfigFactory {
    func getConfig() -> Config {
        let bundle = Bundle.init(for: type(of: self))
        let configURL = bundle.url(forResource: "config", withExtension: "json")!
        let data = try! Data(contentsOf: configURL)

        let config = try! jsonDecoderService.decode(ConfigFromJSON.self, from: data)
        return config
    }
}











private struct ConfigFromJSON: Decodable {

    struct APIBaseConfigFromJSON: APIBaseConfig, Decodable {
        var scheme: String
        var host: String
        var path: String
        var queryItems: [String : String]
    }

    let apiBaseConfig: APIBaseConfigFromJSON
}

extension ConfigFromJSON: Config {
    var apiBase: APIBaseConfig {
        return apiBaseConfig
    }


}
