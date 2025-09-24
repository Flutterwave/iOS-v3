<p align="center">
    <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo/full.svg" width="50%"/>
</p>

# Flutterwave iOS SDK

 <p align="center">
    <img title="Flutterwave" height="100%" src="https://github.com/Flutterwave/FlutterwaveSDK/blob/master/FlutterwaveSDK/Assets/Assets.xcassets/FlutterwaveScreenshot.imageset/FlutterwaveScreenshot.png" width="100%"/>
 </p>

## Introduction

The Flutterwave iOS SDK simplifies and accelerates the process of integrating Flutterwave's payment services into your iOS applications.

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Initialization or Instantiation](#initialization-or-instantiation)
4. [Usage](#usage)
    1. [Feature](#feature)
        1. [Feature Description](#feature-description)
    2. [Use Case](#use-case)
    3. [Flow](#flow)
    4. [Sample Code](#sample-code)
    5. [Sample Response (200 and 400)](#sample-response-200-and-400)
    6. [Handling Error Messages](#handling-error-messages)
5. [Testing](#testing)
6. [Debugging Errors](#debugging-errors)
7. [Support](#support)
8. [Contribution Guidelines](#contribution-guidelines)
9. [License](#license)
10. [Changelog](#changelog)


## Requirements

To use the Flutterwave iOS SDK, you need the following:

- iOS version 11.0 or later
- Swift version 5.3 or later
- CocoaPods or Carthage for dependency management

## Installation

To install the Flutterwave iOS SDK, you can use either CocoaPods or Carthage:

- **CocoaPods**:
    1. Add the following line to your `Podfile`:
       ```
       pod 'FlutterwaveSDK'
       ```
    2. Run `pod install` in your terminal.

- **Carthage**:
    1. Add the following line to your `Cartfile`:
       ```
       github "Flutterwave/iOS-v3"
       ```
    2. Run `carthage update` and follow the integration steps.

1. Run the following command in your terminal:
```
pod install
```

# Carthage

1. Add the following line to your Cartfile:
``` 
"github Flutterwave/iOS-v3"
```
2. Run the following command in your terminal:
```
carthage update
```

## Initialization or Instantiation

Before using the SDK, you need to initialize it with your API keys. Here's how you can do it:

```swift
import FlutterwaveSDK

config.publicKey = "[PUB_KEY]" //Public key
config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key
```
## Usage

The SDK offers the following features:

### Collections: 
Support for various payment methods including Cards, Accounts, Mobile Money, Bank Transfers, USSD, and Barter.

### Recurring Payments: 
Tokenization and Subscription capabilities are also provided.

# Use Case
Consider a scenario where you have an e-commerce app. You can use the Flutterwave iOS SDK to handle the checkout process efficiently.

# Flow
Collect payment details from the user.
Initialize the Flutterwave SDK with the necessary parameters.
Process the payment using various payment methods such as cards, mobile money, USSD, bank transfer, etc.
Receive and handle the payment response.

## Sample Code
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
   config.allowSaveCard = true //This should display the `RememberCard` component. false hides the component
   let controller = FlutterwavePayViewController()
   let nav = UINavigationController(rootViewController: controller)
   controller.amount = "[]" // This is the amount to be charged.
   controller.delegate = self
   self.present(nav, animated: true)
}
```
## Sample Response (200)
### Successful Payment Response:
``` json
{
  "status": "success",
  "message": "Charge initiated",
  "data": {
    "id": 288192886,
    "tx_ref": "sample_ref",
    "flw_ref": "FLW275389391",
    // other fields
  }
}
```


## Testing

Thoroughly test the integration with various payment scenarios to ensure a smooth user experience. Flutterwave provides testing helpers that allow you to simulate different payment scenarios.

For your convenience, here are the testing helpers available:

- **Card Testing**: Use the card details provided in the [Flutterwave documentation](https://developer.flutterwave.com/docs/integration-guides/testing-helpers) to simulate successful and failed card transactions.

- **Mobile Money Testing**: Simulate mobile money transactions using the provided testing details. Refer to the [Flutterwave documentation](https://developer.flutterwave.com/docs/integration-guides/testing-helpers) for more information.

- **Bank Transfer Testing**: Test bank transfer scenarios with the testing account details available in the [Flutterwave documentation](https://developer.flutterwave.com/docs/integration-guides/testing-helpers).

- **USSD Testing**: You can also test USSD transactions using the provided USSD codes and instructions from the [Flutterwave documentation](https://developer.flutterwave.com/docs/integration-guides/testing-helpers).

These testing helpers help you ensure that your integration handles various payment scenarios effectively before deploying your application to a production environment. It's recommended to thoroughly test your integration with these testing details to provide a reliable payment experience to your users.


## Handling Transactions

When handling transactions using the Flutterwave iOS SDK, you can implement callback methods to respond to different transaction outcomes.
``` swift

// MARK: - Transaction Handling
    
    // This method is called when a transaction is successful
    func transactionSuccessful(flwRef: String?, responseData: FlutterwaveDataResponse?) {
        print("DATA Returned \(responseData?.flwRef ?? "Failed to return data")")
        // You can add additional logic here to handle a successful transaction
    }
    
    // This method is called when a transaction fails
    func transactionFailed(flwRef: String?, responseData: FlutterwaveDataResponse?) {
        print("Failed to return data with FlwRef \(flwRef.orEmpty())")
        // You can add additional logic here to handle a failed transaction
    }
```

## Handling Error Messages
When handling errors, you can extract error messages from the response to provide meaningful feedback to users.

## Testing
Thoroughly test the integration with various payment scenarios to ensure a smooth user experience.

## Debugging Errors
If you encounter issues, refer to the SDK documentation for troubleshooting guidance.

## Support
If you need further help with this SDK, feel free to get in touch with our Developer Experience (DX) team via [email](mailto:developers@flutterwavego.com) or join the conversation on [Slack](https://bit.ly/34Vkzcg).

You can also follow us [@FlutterwaveEng](https://twitter.com/FlutterwaveEng) to stay updated and share your thoughts with us. 😊

**Please note that merchant must be PCI-DSS compliant to be able to charge cards on FlutterwaveSDK.**

## Contribution Guidelines
We welcome contributions to enhance the Flutterwave iOS SDK. Please review our contribution guidelines before submitting pull requests.

## License
The Flutterwave iOS SDK is open-source and available under the MIT License.

## Changelog
Stay updated with the latest features and changes by referring to our changelog.


