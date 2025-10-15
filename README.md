<p align="center">
    <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo/full.svg" width="50%"/>
</p>

# Flutterwave iOS SDK

 <p align="center">
    <img title="Flutterwave" height="100%" src="https://github.com/Flutterwave/FlutterwaveSDK/blob/master/FlutterwaveSDK/Assets/Assets.xcassets/FlutterwaveScreenshot.imageset/FlutterwaveScreenshot.png" width="100%"/>
 </p>

## Introduction

The Flutterwave iOS SDK streamlines and speeds up the integration of Flutterwave's payment services into your iOS applications.

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

To use the Flutterwave iOS SDK, you must have the following:

- iOS version 11.0 or newer.
- Swift version 5.3 or newer.
- CocoaPods or Carthage for managing dependency.

## Installation

To install the Flutterwave iOS SDK, you have two options: you can use either CocoaPods or Carthage.

- **CocoaPods**:
    1. Add the following line to your `Podfile`:
       ```
       pod 'FlutterwaveSDK'
       ```
    2. In your terminal run the command:
       ```
       pod install
       ```

- **Carthage**:
    1. Add the following line to your `Cartfile`:
       ```
       github "Flutterwave/iOS-v3"
       ```
    2. Run the command :
        ```
        `carthage update` 
        ```
       Then, follow the integration steps.



## Initialization or Instantiation

To use the SDK, you must first initialize it with your API keys. Here's how to do that:

```swift
import FlutterwaveSDK

config.publicKey = "[PUB_KEY]" //Your Public Key.
config.encryptionKey = "[ENCRYPTION_KEY]" //Your Encryption Key.
```
## Usage

The SDK provides the following features:

### Collections: 
Support for various payment methods including Cards, Accounts, Mobile Money, Bank Transfers, USSD, and Barter.

### Recurring Payments: 
Tokenization and Subscription functionalities are also provided.

# Use Case
Imagine you have an e-commerce app. You can utilize the Flutterwave iOS SDK to manage the checkout process efficiently.

# Flow
Collect payment details from the customer.
Initialize the Flutterwave SDK with the required parameters.
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
   config.email = "user@flw.com" // This is the email address of the customer.
   config.isStaging = false // Set this to true to collect payment in the test environment and false for the live environment.
   config.phoneNumber = "077883***1" //This is the customer's Phone number.
   config.transcationRef = "IOS TEXT" // This is a unique reference, specific to the particular transaction being carried out. It is automatically generated for each transaction when not provided by the merchant. 
   config.firstName = "Yemi" // This is the customers first name.
   config.lastName = "Desola" //This is the customers last name.
   config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information.
   config.narration = "simplifying payments for endless possibilities"
   config.publicKey = "[PUB_KEY]" //Your Public key.
   config.encryptionKey = "[ENCRYPTION_KEY]" //Your Encryption key.
   config.isPreAuth = false  // Set to true for preauthorized card transactions.
   let controller = FlutterwavePayViewController()
   let nav = UINavigationController(rootViewController: controller)
   controller.amount = "[]" // This is the amount to be charged from the customer.
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

Thoroughly test the integration with various payment scenarios to ensure a smooth user experience. Flutterwave provides testing helpers to simulate different payment scenarios.

For your convenience, here are the testing helpers available:

- **Card Testing**: Use the card details provided in our [documentation](https://developer.flutterwave.com/v3.0.0/docs/testing#cards) to simulate both successful and failed card transactions.

- **Mobile Money Testing**: Simulate mobile money transactions using the provided testing details. Refer to our   [documentation](https://developer.flutterwave.com/v3.0.0/docs/testing#mobile-money) for more information.

- **Bank Transfer Testing**: Test bank transfer scenarios with the test account details provided in our [documentation](https://developer.flutterwave.com/v3.0.0/docs/testing#testing-transfers).

- **USSD Testing**: In the test environment, USSD transactions will automatically be paid (transition to "successful") after a few seconds. Learn more about how USSD payments work [here](https://developer.flutterwave.com/v3.0.0/docs/ussd).

These testing helpers help ensure that your integration effectively handles various payment scenarios before deploying your application to a production(live) environment. It is recommended to thoroughly test your integration using these testing details to provide a reliable payment experience for your customer's.


## Handling Transactions

When handling transactions using the Flutterwave iOS SDK, you can implement callback methods to respond to different transaction outcomes.
``` swift

// MARK: - Transaction Handling
    
    // This method is called when a transaction is successful.
    func transactionSuccessful(flwRef: String?, responseData: FlutterwaveDataResponse?) {
        print("DATA Returned \(responseData?.flwRef ?? "Failed to return data")")
        // You can add additional logic here to handle a successful transaction.
    }
    
    // This method is called when a transaction fails.
    func transactionFailed(flwRef: String?, responseData: FlutterwaveDataResponse?) {
        print("Failed to return data with FlwRef \(flwRef.orEmpty())")
        // You can add additional logic here to handle a failed transaction.
    }
```

## Handling Error Messages
When handling errors, extract error messages from the response to provide meaningful feedback to customer's.

## Testing
Thoroughly test the integration with various payment scenarios to ensure a smooth customer experience.

## Debugging Errors
If you encounter issues, refer to the [SDK documentation](https://developer.flutterwave.com/v3.0.0/docs/common-errors) for troubleshooting guidance.

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


