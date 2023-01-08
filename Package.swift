// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoundationX",
    platforms: [.iOS(.v13), .macOS(.v11), .watchOS(.v7)],
    products: [
        .library(
            name: "FoundationX",
            targets: ["FoundationX"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FoundationX",
            dependencies: []
        )
    ]
)
