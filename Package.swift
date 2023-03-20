// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YAnalyticsPendo",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YAnalyticsPendo",
            targets: ["YAnalyticsPendo"]
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
            name: "YAnalyticsPendo",
            dependencies: [
                .product(name: "Pendo", package: "pendo-mobile-ios")
            ]
        ),
        .testTarget(
            name: "YAnalyticsPendoTests",
            dependencies: ["YAnalyticsPendo"]
        )
    ]
)
