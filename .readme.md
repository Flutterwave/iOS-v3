<p align="center">
    <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo/full.svg" width="50%"/>
</p>

# FlutterwaveSDK
 
**Flutterwave IOS SDK** allows you to build a quick, simple and excellent payment experience in your iOS app. We provide powerful and customizable UI screens and elements that can be used out-of-the-box to collect your users' payment details.
 
 <p align="center">
    <img title="Flutterwave" height="100%" src="https://github.com/Flutterwave/FlutterwaveSDK/blob/master/FlutterwaveSDK/Assets/Assets.xcassets/FlutterwaveScreenshot.imageset/FlutterwaveScreenshot.png" width="100%"/>
 </p>
 
## Example
 
 To run the example project, clone the repo, and open `FlutterwaveSDK.xcworkspace` in the Example directory with **Xcode**, run and build and you are good to go!
 
1. If you don’t have an account, sign up for a [Flutterwave account](https://dashboard.flutterwave.com/signup).
2. Fill in the following `config details` in the `Viewcontroller.swift` to configure your payment type
 
```
config.paymentOptionsToExclude = []
config.currencyCode = "[NGN,USD,KES,RWF,ZAR,GBP,GHS,ZMF,XAF,XOF, e.t.c ]" // This is the specified currency to charge in.
config.email = "user@flw.com" // This is the email address of the customer
config.isStaging = false // Toggle this for staging and live environment
config.phoneNumber = "077883***1" //Phone number
config.transcationRef = "IOS TEXT" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
config.firstName = "Yemi" // This is the customers first name.
config.lastName = "Desola" //This is the customers last name.
config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
config.narration = "simplifying payments for endless possibilities"
config.publicKey = "[PUB_KEY]" //Public key
config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key
config.isPreAuth = false  // This should be set to true to preauthoize card transactions
let controller = FlutterwavePayViewController()
let nav = UINavigationController(rootViewController: controller)
controller.amount = "[]" // This is the amount to be charged.
controller.delegate = self
self.present(nav, animated: true)
```
 
After this is done, you can make test payments, please ensure `config.isStaging = true`,   toggle to test mode and use the keys gotten when you toggle to test mode on your dashboard. 

*Please note that the test cards will not work with Live API keys, they will only work on the staging environment.*
 
Please go to https://developer.flutterwave.com/docs/test-cards for a list of test card numbers.

**Please note that merchant must be PCI-DSS compliant to be able to charge cards on Flutterwave SDK**
 
 
## Requirements
Flutterwave SDK is compatible with iOS apps running on iOS 11.0 and above. It requires Xcode 10.0+ to build the source.
 
 
## Installation
 
FlutterwaveSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile and run `pod install`:
 
```
pod 'FlutterwaveSDK'
```
 
 
## Usage
 
```swift
 
import FlutterwaveSDK
 
class ViewController: UIViewController, FlutterwavePayProtocol {
 
func tranasctionSuccessful(flwRef: String?, responseData: FlutterwaveDataResponse?) {
print("Successful with \(responseData?.flwRef ?? "Failed to return data")")
 
}
 
func tranasctionFailed(flwRef: String?, responseData: FlutterwaveDataResponse?) {
print( "Failed transaction with FlwRef \(flwRef.orEmpty())")
}
 
let flutterLabel = UILabel()
let exampleLabel = UILabel()
let underLineView = UIView()
let launchButton = UIButton(type: .system)
 
 
 
@objc func showExample(){
   let config = FlutterwaveConfig.sharedConfig()
   config.paymentOptionsToExclude = []
   config.currencyCode = "NGN" // This is the specified currency to charge in.
   config.email = "user@flw.com" // This is the email address of the customer
   config.isStaging = false // Toggle this for staging and live environment
   config.phoneNumber = "077883***1" //Phone number
   config.transcationRef = "IOS TEXT" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
   config.firstName = "Yemi" // This is the customers first name.
   config.lastName = "Desola" //This is the customers last name.
   config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
   config.narration = "simplifying payments for endless possibilities"
   config.publicKey = "[PUB_KEY]" //Public key
   config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key
   config.isPreAuth = false  // This should be set to true for preauthorize card transactions
   let controller = FlutterwavePayViewController()
   let nav = UINavigationController(rootViewController: controller)
   controller.amount = "[]" // This is the amount to be charged.
   controller.delegate = self
   self.present(nav, animated: true)
}
 
```
 
## Contributing
Contributions of any kind are welcomed, including bug fixes, new features, and documentation improvements. The first thing to do is to please open an issue describing what you want to build and we will discuss how to move forward. Otherwise, go ahead and open a pull request for minor changes such as typo fixes and one liners.
 
 
## Author
 
Flutterwave Developers
 
## License
 
FlutterwaveSDK is available under the MIT license. See the [LICENSE](https://github.com/Flutterwave/FlutterwaveSDK/blob/master/LICENSE) file for more info.

