import SwiftUI
import MuseumKit

struct PortfolioView: View {

    var arts = [Art]() {
        didSet{
            print("sdfsd")
        }
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                PortfolioCollectionView(width: geometry.size.width)
            }
            .padding(.horizontal, 5)
            .navigationBarTitle("Rijksmuseum")
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(arts: .init())
    }
}
