// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NameXCore",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [.library(name: "NameXCore", targets: ["NameXCore"])],
    targets: [.target(name: "NameXCore"), .testTarget(name: "NameXCoreTests", dependencies: ["NameXCore"])]
)
