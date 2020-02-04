import MuseumKit

public class AppState {

    public init() { }

    @Published var arts: [Art] = []

    @Published public var currentRoute: Route = .artCollection

    @Published public var isActive = false
}

