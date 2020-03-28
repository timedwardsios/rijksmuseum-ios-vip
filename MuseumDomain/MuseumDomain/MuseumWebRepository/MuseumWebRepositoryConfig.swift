import Utils

struct MuseumWebRepositoryConfig: WebRepositoryConfig {
    var urlScheme: URLScheme = .https

    var hostname = "www.rijksmuseum.nl"

    var path = "/api/en"

    var queryItems = [
        "key": "VV23OnI1",
        "format": "json"
    ]
}
