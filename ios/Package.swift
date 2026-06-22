// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_media_metadata_plus",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "flutter-media-metadata-plus", targets: ["flutter_media_metadata_plus"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "flutter_media_metadata_plus",
            dependencies: [],
            path: "Classes"
        )
    ]
)
