import MuseumKit
import SwiftUI
import SDWebImageSwiftUI

struct PortfolioRowView: View {

    let art: Art

    var body: some View {
        HStack(spacing: 0) {
            WebImage(url: art.imageURL)
                .indicator(.activity)
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
