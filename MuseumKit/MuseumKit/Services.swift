public struct Services {

    public let museumWebService: MuseumWebService

    public init() {
        self.museumWebService = MuseumWebServiceDefault(
            config: MuseumWebServiceConfig(),
            urlSession: .shared,
            jsonDecoder: .init()
        )
    }
}
