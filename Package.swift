// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DGChatWidgetPackage",
    platforms: [
        .iOS(.v13),
    ],
    products: [.
        .library(
            name: "DGChatWidgetPackage",
            targets: ["DGChatWidgetPackage"]),
    ],
    dependencies: [ ],
    targets: [
        .binaryTarget(
            name: "DGChatSDK",
            path: "DGChatSDK.xcframework"
        ),
        .target(
            name: "DGChatWidgetPackage",
            dependencies: ["DGChatSDK"]),
    ]
)
