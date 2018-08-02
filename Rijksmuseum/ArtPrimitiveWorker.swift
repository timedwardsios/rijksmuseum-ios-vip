
import UIKit

protocol ArtPrimitiveService {
    func loadPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void)
}

class ArtPrimitiveWorker{
    let artPrimitiveSource:ArtPrimitiveService
    init(artPrimitiveSource:ArtPrimitiveService) {
        self.artPrimitiveSource = artPrimitiveSource
    }

    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void){
        artPrimitiveSource.loadPrimitives { (result) in
            switch result {
            case .success(let artPrimitives):
                completion(.success(artPrimitives))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
