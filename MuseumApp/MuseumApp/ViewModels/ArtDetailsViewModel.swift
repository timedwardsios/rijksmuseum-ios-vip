import Foundation
import MuseumDomain
import Utils
import RxSwift
import RxCocoa

public class ArtDetailsViewModel {
    internal init(artID: String) {
        self.artID = artID
    }
    

    public struct Outputs {
        public let imageURL = BehaviorRelay<URL?>(value: nil)
    }

    public let outputs = Outputs()

    private let disposeBag = DisposeBag()
    private let artID: String

    public init(artID: String,
                artController: ArtController = ArtControllerDefault()) {
        self.artID = artID
        bind()
    }

    func bind() {
        
        appState.arts
            .asDriver()
            .compactMap { $0.first { $0.id == self.artID }?.imageURL }
            .drive(outputs.imageURL)
            .disposed(by: disposeBag)
    }
}
