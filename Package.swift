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
            url: "https://gitlab.com/utsmannn/composeremotelayoutcore/-/raw/v0.0.1-alpha05/ComposeRemoteLayoutCore.xcframework.zip?ref_type=tags&inline=false",
            checksum: "3b0441d036a91b979976fd5da6ece45e1bcb073b5aba03c0a3d433fcc17fea01"
        ),
        .target(
            name: "ComposeRemoteLayoutSwift",
            dependencies: ["ComposeRemoteLayoutCore"],
            path: "Sources/ComposeRemoteLayoutSwift"
        ),
    ]
)
