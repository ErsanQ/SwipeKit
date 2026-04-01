// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwipeKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwipeKit",
            targets: ["SwipeKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwipeKit",
            dependencies: [],
            path: "Sources/SwipeKit",
            exclude: ["Examples"]),
    ]
)
