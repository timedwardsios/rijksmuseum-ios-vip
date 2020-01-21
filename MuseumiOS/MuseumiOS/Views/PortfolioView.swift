import SwiftUI
import MuseumKit

struct PortfolioView: View {

    @ObservedObject var model: Model

    var body: some View {
        NavigationView {
            List(model.arts, id: \.id) {
                Text("\($0.title)")
            }
            .navigationBarTitle("Rijksmuseum")
        }
    }
}

//struct PortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioView(arts: .init())
//    }
//}
