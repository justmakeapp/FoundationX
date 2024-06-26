// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "FoundationX",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "FoundationX",
            targets: ["FoundationX"]
        ),
    ],
    targets: [
        .target(name: "FoundationX"),
    ]
)
