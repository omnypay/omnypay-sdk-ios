## Registration

Register your app at http://www.omnypay.net. You will  be assigned a merchant id. Please save this for future.


## iOS SDK
OmnyPay provides various iOS SDKs in Swift that enables retailer/merchant iOS apps to integrate OmnyPay’s rich checkout experience for a shopper using the Retailer’s mobile app. OmnyPay SDK provides simple functions to perform operations on OmnyPay platform.


|   **SDK**   | **Description**                                                               | **Version** | **Release Date** |
|:-----------:|-------------------------------------------------------------------------------|:-----------:|:----------------:|
| OmnyPayAPI  | Provides access to OmnyPay Platform API                                       |     1.0     |    08-Dec-2016   |
| OmnyPayScan | Provides an easy way to scan machine readable codes like QRCode, Barcode etc. |     1.0     |    08-Dec-2016   |


### Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 2.3 or Objective C (Swift 3.0 support will be coming soon)


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
    platform :ios, '8.0'

    target 'OmnyPayDemoApp' do

      use_frameworks!

      pod 'Starscream', '~> 1.1.4'


    post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '2.3' # or '3.0'
        end
      end
    end

    end
    ```

    ![PodFile](DocAssets/images/PodFile.png)

9.  Open terminal and run `pod install` in your project's root directory.
10. If you are including OmnyPayScan SDK then **follow Step 1-6 for OmnyPayScan.framework**.
11. That's it. Open the workspace and build.

