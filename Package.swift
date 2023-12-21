// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SteganographyKit",
    platforms: [
        .iOS(.v13),
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
