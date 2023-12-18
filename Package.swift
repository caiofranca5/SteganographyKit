// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SteganographyKit",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "SteganographyKit",
            targets: ["SteganographyKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SteganographyKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SteganographyKitTests",
            dependencies: ["SteganographyKit"],
            path: "Tests"
        ),
    ]
)
