import PackageDescription

let package = Package(
  name: "swift-typescript-template",
  targets: [
    Target(name: "server"),
  ],
  dependencies: [
    .Package(url: "https://github.com/Zewo/HTTPServer.git", majorVersion: 0, minor: 14),
    .Package(url: "https://github.com/Zewo/HTTPClient.git", majorVersion: 0, minor: 14)
  ],
  exclude: [
    "Sources/client"
  ]
)
