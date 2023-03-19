// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YPendo",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YPendo",
            targets: ["YPendo"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pendo-io/pendo-mobile-ios",
            .upToNextMajor(from: "2.10.0")
        )
    ],
    targets: [
        .target(
            name: "YPendo",
            dependencies: [
                .product(name: "Pendo", package: "pendo-mobile-ios")
            ]
        ),
        .testTarget(
            name: "YPendoTests",
            dependencies: ["YPendo"]
        )
    ]
)
