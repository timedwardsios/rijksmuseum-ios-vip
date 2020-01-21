import MuseumKit
import SwiftUI

struct PortfolioCellView: View {

    let art: Art

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
            Text("\(art.artist)")
        }.padding(5)
    }
}

struct PortfolioCellView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCellView(art: ArtTmp()).previewLayout(.fixed(width: 100, height: 200))
    }
}

struct ArtTmp: Art {
    var id = "ID"

    var title = "TITLE"

    var artist = "ARTIST"

    var imageURL = URL.init(string: "www.google.com")!
}
