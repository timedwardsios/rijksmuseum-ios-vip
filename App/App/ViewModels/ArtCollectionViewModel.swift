import Foundation
import Core
import Utils
import Combine

public struct ArtCollectionViewModel {

    public typealias UseCases = FetchArts

    public struct Inputs {
        public let didAppear = PassthroughSubject<Void, Never>()
        public let didSelectArt = PassthroughSubject<Art, Never>()
    }

    public struct Outputs {
        public let arts = CurrentValueSubject<[Art], Never>([])
    }

    public let inputs = Inputs()
    public let outputs = Outputs()

    private let cancelBag = CancelBag()

    private let useCases: UseCases

    public init(useCases: UseCases) {
        self.useCases = useCases
        bind()
    }
}

private extension ArtCollectionViewModel {
    func bind() {
        inputs.didAppear
            .flatMap { _ in
                self.useCases.getArts().handleError {
                    print($0)
                }.replaceError(with: [])
            }
            .subscribe(outputs.arts)
            .store(in: cancelBag)

//        inputs.didSelectArt
//            .asSignal()
//            .map { AppState.Route.artDetails(artID: $0.id) }
//            .emit(to: appState.currentRoute)
//            .disposed(by: disposeBag)
    }
}
