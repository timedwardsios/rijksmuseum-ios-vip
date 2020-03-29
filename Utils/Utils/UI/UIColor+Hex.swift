import UIKit

public extension UIColor {
    convenience init(fromHex hexString: String, alpha: CGFloat) {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        assert(hexString.count == 6, "Invalid hex")

        var rgbValue: UInt64 = 0

        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(fromHex hexString: String) {
        self.init(fromHex: hexString, alpha: 1)
    }
}
