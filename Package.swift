// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ComposeRemoteLayoutSwift",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ComposeRemoteLayoutSwift",
            targets: ["ComposeRemoteLayoutSwift"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "ComposeRemoteLayoutCore",
            url: "https://gitlab.com/utsmannn/composeremotelayoutcore/-/raw/dae5a8e/ComposeRemoteLayoutCore.xcframework.zip?ref_type=tags&inline=false",
            checksum: "fc06386201969062ccbba8a14254b63f42f223479853d42e927779f49f69ee2e"
        ),
        .target(
            name: "ComposeRemoteLayoutSwift",
            dependencies: ["ComposeRemoteLayoutCore"],
            path: "Sources/ComposeRemoteLayoutSwift"
        ),
    ]
)
