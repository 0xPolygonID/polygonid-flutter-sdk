// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "polygonid_flutter_sdk",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(name: "polygonid-flutter-sdk", targets: ["polygonid_flutter_sdk"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "polygonid_flutter_sdk",
            dependencies: ["libpolygonidC"],
            path: "Sources/polygonid_flutter_sdk"
        ),
        .target(
            name: "libpolygonidC",
            dependencies: ["libpolygonid"],
            path: "Sources/libpolygonidC"),
        .binaryTarget(
            name: "libpolygonid",
            path: "Frameworks/libpolygonid.xcframework"),
    ]
)
