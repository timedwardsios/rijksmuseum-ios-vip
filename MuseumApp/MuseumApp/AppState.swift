import MuseumDomain
import Utils
import RxSwift
import RxRelay

public class AppState {

    public let arts = BehaviorRelay<[Art]>(value: [])

    public let lifecycle = BehaviorRelay<Lifecycle>(value: .launching)

    public let currentRoute = BehaviorRelay<Route>(value: .artCollection)

    public init() {}
}

public extension AppState {
    enum Lifecycle {
        case launching
        case launched
        case background
        case foreground
    }

    enum Route {
        case artCollection
        case artDetails(artID: String)
        case alert(Alert)
    }
}
