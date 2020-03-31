import Foundation
import MuseumCore
import Utils
import RxSwift
import RxCocoa

public class ArtCollectionViewModel {

    public struct Inputs {
        public let didAppear = PublishRelay<Void>()
        public let didTriggerRefresh = PublishRelay<Void>()
        public let didSelectArt = PublishRelay<Art>()
    }

    public struct Outputs {
        public let arts = BehaviorRelay(value: [Art]())
        public let isRefreshing = BehaviorRelay(value: false)
    }

    public let inputs = Inputs()
    public let outputs = Outputs()

    private let disposeBag = DisposeBag()

    private let fetchArt: FetchArts

    public init(fetchArt: FetchArts) {
        self.fetchArt = fetchArt
        bind()
    }
}

private extension ArtCollectionViewModel {
    func bind() {
        Observable.of(
            inputs.didAppear.take(1),
            inputs.didTriggerRefresh.asObservable()
        )
            .merge()
            .flatMapLatest { _ in
                self.fetchArt.execute(())
                    .do(onError: { _ in
//                        self.appState.currentRoute.accept(.alert(.error($0)))
                        self.outputs.isRefreshing.accept(false)
                    }, onCompleted: {
                        self.outputs.isRefreshing.accept(false)
                    }, onSubscribe: {
                        self.outputs.isRefreshing.accept(true)
                    })
                    .asDriver(onErrorJustReturn: [])
            }
            .asDriver(onErrorJustReturn: [])
            .drive(outputs.arts)
            .disposed(by: disposeBag)

//        inputs.didSelectArt
//            .asSignal()
//            .map { AppState.Route.artDetails(artID: $0.id) }
//            .emit(to: appState.currentRoute)
//            .disposed(by: disposeBag)
    }
}
