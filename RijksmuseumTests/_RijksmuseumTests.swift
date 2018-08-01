
import XCTest
@testable import Rijksmuseum

//class RijksmuseumTests: XCTestCase {
//
//    var artService:ArtService?
//
//    override func setUp() {
//        super.setUp()
//        artService = ArtService()
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testGetArt() {
//        let exp = XCTestExpectation()
//        let artRequest = ArtRequest(page: 0,
//                                    starredOnly: false)
//        artService?.getArtResults(withRequest: artRequest,
//                                  completion: {(result) in
//                                    switch result {
//                                    case .success(let result):
//                                        
//                                        exp.fulfill()
//                                    case .failure(_):
//                                        XCTAssert(false)
//                                    }
//        })
//        wait(for: [exp], timeout: 5)
//    }
//}
