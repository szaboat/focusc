// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "FocusC",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "FocusC", targets: ["FocusC"])
    ],
    targets: [
        .executableTarget(
            name: "FocusC",
            path: "Sources/FocusC"
        )
    ]
)
