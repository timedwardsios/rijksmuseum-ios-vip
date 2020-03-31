import MuseumCore
import Utils
import RxSwift

final public class GetCurrentRoute: UseCase {

    private let : ArtRepository

    init(artRepository: ArtRepository) {
        self.artRepository = artRepository
    }

    public func execute(_ argument: Void) -> Observable<[Art]> {
        artRepository.fetchArts()
    }
}
