// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwipeKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
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
            path: "Sources/SwipeKit"),
        .testTarget(
            name: "SwipeKitTests",
            dependencies: ["SwipeKit"],
            path: "Tests/SwipeKitTests"),
    ]
)
