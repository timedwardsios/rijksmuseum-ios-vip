# rijksmuseum-ios-vip

This is an iOS app demonstrating use of the VIP architecture from [clean-swift.com](http://clean-swift.com).

Instead of the traditional VIPER architecture where the presenter is the center of the module, VIP has uni-directional data flow, seperating units of functionality quite nicely, and makes testing unit boundries fairly trivial.

ViewController->Interactor->Presenter->ViewController etc.

The app also features DI and TDD, and can perhaps explain how these can be included in VIP.
