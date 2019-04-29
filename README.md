# rijksmuseum-ios-vip-example

This is an iOS app demonstrating use of the VIP architecture from [clean-swift.com](http://clean-swift.com).

Instead of the more traditional VIPER architecture where the presenter is the center of the module, VIP has uni-directional data flow, seperating units of functionality quite nicely, and makes testing unit boundries fairly trivial.

ViewController -> Interactor -> Presenter -> ViewController etc.

The app also features dependency injection, TDD, and many other iOS programming best practises. It uses the [rijksmuseum.nl](http://rijksmuseum.nl) API, and a couple 3rd party libs.
