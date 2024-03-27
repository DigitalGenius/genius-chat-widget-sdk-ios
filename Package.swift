// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DGChatWidgetPackage",
    platforms: [
        .iOS(.v13), // Adjust the platform version as needed
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DGChatWidgetPackage",
            targets: ["DGChatWidgetPackage"]),
    ],
    dependencies: [
        // Add any dependencies here
    ],
    targets: [
        .binaryTarget(
            name: "DGChatSDK",
            path: "DGChatSDK.xcframework" // Adjust the path to your XCFramework
        ),
        .target(
            name: "DGChatWidgetPackage",
            dependencies: ["DGChatSDK"]), // Add the binary target as a dependency
        .testTarget(
            name: "DGChatWidgetPackageTests",
            dependencies: ["DGChatWidgetPackage"]),
    ]
)
