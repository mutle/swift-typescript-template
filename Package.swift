// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "swift-typescript-template",
  products: [
    .executable(name: "server", targets: ["server"])
  ],
  dependencies: [
    .package(url: "https://github.com/mutle/swift-web.git", .upToNextMajor(from: "0.0.1"))
  ],
  targets: [
    .target(name: "server", dependencies: [.productItem(name: "web", package: nil)]),
  ]
)
