// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusicStaffView",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MusicStaffView",
            targets: ["MusicStaffView"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Music", url: "git@github.com:mmuszynski/Music.git", from: Version("1.0.0")),
        .package(name: "SVGParser", url: "git@github.com:mmuszynski/SVGParser", from: Version("0.0.11"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MusicStaffView",
            dependencies: ["Music", "SVGParser"],
            resources: [.process("Opus/")]),
        .testTarget(
            name: "MusicStaffViewTests",
            dependencies: ["MusicStaffView"]),
    ]
)
