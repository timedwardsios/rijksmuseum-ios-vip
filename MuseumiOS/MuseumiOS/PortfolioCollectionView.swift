import SwiftUI
import MuseumKit

struct PortfolioCollectionView: View {

    private let columnSize = 4

    let width: CGFloat

    var arts = [Art]() {
        didSet {
            artsChunked = arts.chunked(into: columnSize)
        }
    }

    var artsChunked = [[Art]]()

    var body: some View {
        VStack {
            ForEach(self.artsChunked.indices) { i in
                PortfolioRowView(arts: self.artsChunked[i], width: self.width)
            }
            Spacer()
        }
    }
}

struct PortfolioCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(arts: .init())
    }
}
