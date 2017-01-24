## Registration

Register your app at http://www.omnypay.net. You will  be assigned a merchant id. Please save this for future.


## iOS SDK
OmnyPay provides various iOS SDKs in Swift that enables retailer/merchant iOS apps to integrate OmnyPay’s rich checkout experience for a shopper using the Retailer’s mobile app. OmnyPay SDK provides simple functions to perform operations on OmnyPay platform.


|   **SDK**   | **Description**                                                               | **Version** | **Release Date** |
|:-----------:|-------------------------------------------------------------------------------|:-----------:|:----------------:|
| OmnyPayAPI  | Provides access to OmnyPay Platform API                                       |     1.0     |    24-Jan-2017   |
| OmnyPayScan | Provides an easy way to scan machine readable codes like QRCode, Barcode etc. **Privacy - Camera Usage Description** should be provided in info.plist |     1.0     |    24-Jan-2017   |
| OmnyPayAuth | Provides an easy way to authenticate user by Touch Id or using Passcode |     1.0     |    24-Jan-2017   |
| OmnyPayIdentity | Provides an easy way to scan an identity document e.g. driver license, and get details regarding the document. **Privacy - Camera Usage Description** should be provided in info.plist|     1.0     |    24-Jan-2017   |
| OmnyPayPIScan | Provides an easy way to scan a credit/debit card and get card details. **Privacy - Camera Usage Description** should be provided in info.plist |     1.0     |    24-Jan-2017   |

### Requirements

- iOS 8.0+
- Xcode 8.1+
- Swift 3.0.1


# Installation


## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

Currently Omnypay does not support CocoaPods but committed to provide it shortly. Please visit the site again on availability of CocoaPods. For those developers who have signed up for developer account already, an email notification about availability will be sent.

## Manual

Until we support CocoaPods installation, you can integrate OmnyPay into your project manually.

#### Embedded Framework
1. Download OmnyPay iOS SDKs <a href="https://github.com/omnypay/omnypay-sdk-ios">here</a>.
2. Navigate to the target configuration window and select the application target under the `Targets` heading in the sidebar.
3. In the tab bar at the top of that window, open the "General" panel.
4. Drag `OmnyPayAPI.framework` to "Embedded Binaries" section.
5. Choose "Copy items if needed" and "Create Groups". Click Finish.

    ![CopyItemsPopup](DocAssets/images/CopyItemsPopUp.png)

6. Verify OmnyPayAPI.framework is added in "Linked Frameworks and Libraries" section also.

    ![EmbeddedBinaries](DocAssets/images/EmbeddedBinaries.png)

7. Create a `Podfile` in your project's root directory (where the xcodeproj file sits). For more information about `Podfile` see [CocoaPods](http://cocoapods.org).
8. Add below in your `Podfile`

    ```ruby
    source 'https://github.com/CocoaPods/Specs.git'
    
    # Include following line if OmnyPayIdentity SDK or OmnyPayPIScan SDK will be used
    source 'http://mobile-sdk.jumio.com/distribution.git'
    
    # Uncomment this line to define a global platform for your project
    platform :ios, '8.0'
    
    target 'project name' do
      # Comment this line if you're not using Swift and don't want to use dynamic frameworks
      use_frameworks!
      
      # Mandatory pod while using OmnyPayAPI SDK
      pod 'Starscream', :git => 'https://github.com/daltoniam/Starscream.git', :branch => 'swift3'
      
      # Mandatory if using OmnyPayIdentity SDK
      pod 'JumioMobileSDK-FAT/Netverify', '2.3.1'
      
      # Mandatory if using OmnyPayPIScan SDK
      pod 'JumioMobileSDK-FAT/Netswipe', '2.3.1'
      
    end
    ```

    ![PodFile](DocAssets/images/PodFile.png)

9. Open terminal and run `pod install` in your project's root directory.
10. If you are including OmnyPayScan SDK then **follow Step 1-6 for OmnyPayScan.framework**.
11. If you are including OmnyPayAuth SDK then **follow Step 1-6 for OmnyPayAuth.framework**.
12. If you are including OmnyPayIdentity SDK then **follow Step 1-6 for OmnyPayIdentity.framework**. For more information about `Jumio` click [here](https://www.jumio.com/).
13. If you are including OmnyPayPIScan SDK then **follow Step 1-6 for OmnyPayPIScan.framework**. For more information about `Jumio` click [here](https://www.jumio.com/).
14. That's it. Open the workspace and build.

