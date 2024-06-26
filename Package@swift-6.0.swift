// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "FoundationX",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FoundationX",
            targets: ["FoundationX"]
        ),
    ],
    targets: [
        .target(
            name: "FoundationX"
        ),
    ],
    swiftLanguageVersions: [.v6]
)
