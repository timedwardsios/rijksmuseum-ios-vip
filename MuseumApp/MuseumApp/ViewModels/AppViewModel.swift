import MuseumCore
import RxSwift
import RxCocoa

public class AppViewModel {

    public struct Inputs {
        public let didFinishLaunching = PublishRelay<Void>().asSignal()
        public let didEnterBackground = PublishRelay<Void>().asSignal()
        public let willEnterForeground = PublishRelay<Art>().asSignal()
        public let didOpenURL = PublishRelay<URL>().asSignal()
    }

    public let inputs = Inputs()

    private let disposeBag = DisposeBag()

    init() {
        bind()
    }

    func bind() {
        inputs.didFinishLaunching.
    }
}

extension AppViewModel {
    public func didFinishLaunching() {
//        appState.lifecycle.accept(.launched)
    }

    public func didEnterBackground() {
//        appState.lifecycle.accept(.background)
    }

    public func willEnterForeground() {
//        appState.lifecycle.accept(.foreground)
    }

    public func didOpenURL(_ url: URL) {
        handleDeepLink(withURL: url)
    }
}

private extension AppViewModel {
    func handleDeepLink(withURL url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
            return
        }

        for queryItem in queryItems {
            switch (queryItem.name, queryItem.value) {
            case let ("showArtWithID", value?):
//                appState.currentRoute.accept(.artDetails(artID: value))
                return
            default:
                break
            }
        }
    }
}
