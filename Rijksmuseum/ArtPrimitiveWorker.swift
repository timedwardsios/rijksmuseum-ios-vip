
import UIKit

protocol ArtPrimitiveService {
    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void)
}

class ArtPrimitiveWorker{
    let artPrimitiveSource:ArtPrimitiveService
    init(artPrimitiveSource:ArtPrimitiveService) {
        self.artPrimitiveSource = artPrimitiveSource
    }

    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void){
        artPrimitiveSource.fetchPrimitives { (result) in
            switch result {
            case .success(let artPrimitives):
                DispatchQueue.main.async {
                    completion(.success(artPrimitives))
                }
            case .failure(_):
                fatalError()
            }
        }
    }
}
