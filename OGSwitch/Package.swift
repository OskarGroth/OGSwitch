// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OGSwitch",
    platforms: [
        .macOS(.v10_10),
    ],
    products: [
        .library(name: "OGSwitch", type: .static, targets: ["OGSwitch"]),
    ],
    targets: [
        .target(name: "OGSwitch"),
    ]
)
