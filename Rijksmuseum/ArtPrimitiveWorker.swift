
import UIKit

protocol ArtPrimitiveWorkerInterface {
    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void)
}

protocol ArtPrimitiveSource {
    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>)->Void)
}

class ArtPrimitiveWorker:ArtPrimitiveWorkerInterface{
    let artPrimitiveSource:ArtPrimitiveSource
    init(artPrimitiveSource:ArtPrimitiveSource) {
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
