import MuseumKit
import SwiftUI
import SDWebImageSwiftUI

struct PortfolioRowView: View {

    let art: Art

    var body: some View {
        HStack {

            VStack {
                WebImage(url: art.imageURL)
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: 66, height: 66)
                }
            .frame(width: 66, height: 66)
            .clipped()
            .cornerRadius(5)
            .shadow(radius: 2)

            VStack(alignment: .leading) {
                Text(art.title).font(.headline)
                Text(art.artist).font(.subheadline)
            }
        }
    }
}

//struct PortfolioRowView: View {
//
//    let arts: [Art]
//
//    let width: CGFloat
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(self.arts, id: \.id) { art in
//                NavigationLink(destination: Text("\(art.title)")) {
//                    PortfolioCellView(art: art)
//                        .frame(width: self.width/4,
//                               height: self.width/4)
//                }
//            }
//        }
//    }
//}

//struct PortfolioRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioRowView(arts: .init(), width: 300).previewLayout(.fixed(width: 300, height: 200))
//    }
//}
