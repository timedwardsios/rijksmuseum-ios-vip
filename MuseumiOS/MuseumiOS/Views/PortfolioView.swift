import SwiftUI
import MuseumKit
import SDWebImageSwiftUI

struct PortfolioView: View {

    @ObservedObject var model: Model

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("\(model.arts.count) results")) {
                    ForEach(model.arts, id: \.id) { art in
                        NavigationLink(destination: DetailsView(art: art)) {
                            PortfolioRowView(art: art)
                                .frame(height: 66)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Rijksmuseum")
        }
    }
}

//struct PortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        var model = Model()
//        PortfolioView(model: model)
//        model.arts = [Art()]
//    }
//}
