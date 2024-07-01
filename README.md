# DGChatSDK

<div align="center">
   <img width="600px" src="./Sources/DGChatSDK/DGChatSDK.docc/Resources/logo-dark.svg" alt="Logo">
</div>

<!--![DigitalGeniusLogo](logo-dark.svg)-->

iOS SDK for DigitalGenius Chat.

## 🏷 License

`DGChatSDK` is a property of Digital Genius Ltd.

### Requirements

- Xcode 14.2+


## Overview

This SDK enables the DigitalGenius Chat Widget to be embedded anywhere inside an iOS app. This is UIKit based SDK and requires minimal setup. Please refer `Demo.xcworkspace` for an example.
 
A DigitalGenius Customer Success Manager will provide you with a `widgetId`, `env` and `scriptVersion` before getting started. Please see the `Integrating SDK to your project` section for details on how to integrate following settings into an iOS app using the SDK.

## Installation 

### Swift Package Manager

To get started, add the DGChatSDK package as a dependency to your project:

    .package(url: "https://github.com/DigitalGenius/genius-chat-widget-sdk-ios.git", from: "1.0.0"),
    
If you're inlcuding this package as a dependecy inside your package, add it to your target using:

    .product(name: "DGChatSDK", package: "DGChatSDK"),

### XCFramework

1. Get the iOS framework that contains a latest version of SDK and extract the zip file.
2. Drag `DGChatSDK.xcframework` into your project.
3. Make sure "Copy items if needed" is selected and click Finish.
4. In the target settings for your app, set the `DGChatSDK.xcframework` to “Embed & Sign”. This can be found in the “Frameworks, Libraries, and Embedded Content” section of the “General” tab.


## Basic usage example.

First of all, import ``DGChatSDK``.
```swift
import DGChatSDK
```

``DGChatSDK`` uses delegate methods to get its configuration items and provide callbacks about user actions. 

```swift
final class MyViewController: UIViewController, DGChatDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        DGChat.delegate = self
    }
}
```

To make everything work as expected, you'll need to implement a ``DGChatDelegate`` protocol.

The most important and required delegate properties are:

`DGChatDelegate.widgetId` - which tells SDK your unique client identifier.

`DGChatDelegate.env` - environment version for your particular case.

`DGChatDelegate.scriptVersion` - a version of the script, used by your organization.

All of these information is provided by a DigitalGenius Customer Success Manager. 

Plase see an example implementation below:

```swift
var widgetId: String {
    "b5e736c9-1508-41df-827e-212e13f52929"
}

var env: String {
    "eu"
}

var scriptVersion: String {
    "1.1.0"
}
```

> ⚠️ It is highly important to provide ``DGChatDelegate.scriptVersion`` as a [Semantic versioning three-part version number](https://en.wikipedia.org/wiki/Software_versioning). Otherwise, you'll encounter runtime error.

And finally, just call ``DGChat/added(to:animated:completion:)`` to present a chat button on top of specified ViewController.
Also there is support of presenting chat over UIView using ``DGChat/added(to:animated:completion:)``, example also provided , this gives additional ways of usage, for e.g. adding widget to PopUp or some custom containers and even over App Window if needed. Same could be also done with UIViewController approach.

## Using Widget metadata

You can specify a `metadata`, provided by vendor for your particular business needs.
To use that, you just need to implement proper ``DGChatDelegate`` method:

```swift
var metadata: String {
    """
    "currentPage": "some-random-string",
    "currentPageTitle": "another-random-string"
    """
}
```

Please note: You should stick to the formatting, provided by Vendor, otherwise `metadata` will be considered as invalid without explicit errors thrown.

## Additional Methods

You can use a set of additional methods to interact directly with Chat Widget. These methods are lised as a part of ``DGChat`` instance.

The `sendMessage` method allows the customer to programmatically send a message on the user behalf. This method is not available once the user is handed over to a crm:

```swift
func sendMessage(_ message: String, completion: @escaping (Result<Void, Error>) -> Void)

func sendMessage(_ message: String) async throws
```

The `launchWidget` method allows the customer to programmatically launch the widget:

```swift
func launchWidget(_ completion: @escaping (Result<Void, Error>) -> Void)

func launchWidget() async throws
```

The `initProactiveButtons` method allows the customer to programmatically trigger the proactive buttons to display:

```swift
func initProactiveButtons(values: String, completion: @escaping (Result<Void, Error>) -> Void)

func initProactiveButtons(values: String) async throws
```

The `minimizeWidget` method allows customer to minimise an expanded chat UI to the "launcher" state programmatically:

```swift
func minimizeWidget(_ completion: @escaping (Result<Void, Error>) -> Void)

func minimizeWidget() async throws
```

See [full methods list](https://docs.digitalgenius.com/docs/methods) for more details.

## Sample project

The interaction model and example usage can be found in Demo project. Please note that all DGChatDelegate methods are implemented in one isolated instance for ease of use, but it's **not** a requirement.

`ManualCallController.swift` - demonstrates a step-by-step call of DGChatSDK from user-defined UI.
`StraightForwardController.swift` - can be useful example for those cases, when you need to present Chat Widget during view presentation process.
`CustomAnimationController.swift` - provides an example of custom animation added to presentation/dismissal process of Chat Widget. 

```swift
DGChat.added(to: self) { [weak self] chatView in
    print("ChatView shown with frame \(chatView.frame)")
}
```

### SwiftUI

If you are using SwiftUI for your project, please use `GeniusChatView` as listed on the example below:

```swift
var body: some View {
    VStack {
        GeniusChatView(
            widgetId: "your_widget_id",
            env: "some.env",
            scriptVersion: "1.1.0")
    }
    .padding()
}
GeniusChatView implementation provided inside SwiftUI Demo Example so you can customize it according to your own app requirements or create your own wrapper based on provided example.
```

### ReactNative

To use Genius SDK in ReactNative projects, please follow these steps:

1. Use `ReactNativePublicDemo/dgchatsdk` folder as a root.
2. Add prebuilt framework (`.xcframework` file) of DGChatSDK for ios into `./dgchatsdk/ios`
3. In `./dgchatsdk folder`  run: `npm install`.
4. After that, run: `cd ios && pod install && cd ..`
5. Open `dgchatsdk.xcworkspace` in `./ios` folder to use from Xcode.
6. Build&run project.
7. Modify `App.tsx` file if needed in `./dgchatsdk` folder
8. Module `DGChatModule` has 3 functions and JS emiters for chat actions callbacks.
9. Please consult example of usage in `App.tsx`.

Initial setup will look like:

```js
DGChatModule.showDGChatView(
  'Place your widgetId here',
  'Place your flowURL here',
  'Place a version of SDK here',
  'Place your widget environment here',
);
```

And a callbacks section:

```js
const eventEmitter = new NativeEventEmitter(DGChatModule);
let onChatMinimizeClickEventListener = eventEmitter.addListener(
  'OnChatMinimizeClick',
  () => {
    DGChatModule.logActionWith('OnChatMinimizeClick');
  },
);
let onChatEndClickEventListener = eventEmitter.addListener(
  'onChatEndClick',
  () => {
    DGChatModule.logActionWith('onChatEndClick');
  },
);
let onChatLauncherClickEventListener = eventEmitter.addListener(
  'onChatLauncherClick',
  () => {
    DGChatModule.logActionWith('onChatLauncherClick');
  },
);
let onChatProactiveButtonClickEventListener = eventEmitter.addListener(
  'onChatProactiveButtonClick',
  () => {
    DGChatModule.logActionWith('onChatProactiveButtonClick');
  },
);
let onCSATPopoverCloseClicked = eventEmitter.addListener(
  'onCSATPopoverCloseClicked',
  () => {
    DGChatModule.logActionWith('onCSATPopoverCloseClicked');
  },
);
```

For more detailed example, please refer to `App.tsx`.
