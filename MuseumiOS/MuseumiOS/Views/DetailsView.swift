import MuseumKit
import SDWebImageSwiftUI
import SwiftUI

struct DetailsView: View {

    let art: Art

    var body: some View {
        VStack(alignment: .leading) {

            WebImage(url: art.imageURL)
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading) {
                Text(art.title)
                    .font(.headline)

                Text(art.artist)
                    .font(.subheadline)
            }.padding()
        }

    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioRowView(arts: .init(), width: 300).previewLayout(.fixed(width: 300, height: 200))
//    }
//}
