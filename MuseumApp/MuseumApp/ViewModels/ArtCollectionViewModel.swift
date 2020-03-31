import Foundation
import MuseumCore
import Utils
import RxSwift
import RxCocoa

public class ArtCollectionViewModel {

    public struct Inputs {
        public let didAppear = PublishRelay<Void>()
        public let didSelectArt = PublishRelay<Art>()
    }

    public struct Outputs {
        public let arts = BehaviorRelay(value: [Art]())
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
        inputs.didAppear
            .flatMapLatest { _ in
                self.fetchArt.execute(())
                    .asDriver(onErrorJustReturn: [Art]())
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
