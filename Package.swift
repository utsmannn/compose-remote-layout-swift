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
            url: "https://gitlab.com/utsmannn/composeremotelayoutcore/-/raw/4798408/ComposeRemoteLayoutCore.xcframework.zip?ref_type=tags&inline=false",
            checksum: "be564ec6b6e8f9622a575e23eec60eb1bfeb34b7860ea2b03f66673e7414782e"
        ),
        .target(
            name: "ComposeRemoteLayoutSwift",
            dependencies: ["ComposeRemoteLayoutCore"],
            path: "Sources/ComposeRemoteLayoutSwift"
        ),
    ]
)
