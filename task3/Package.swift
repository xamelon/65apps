// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "task3",
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.9.1")
    ],
    
    targets: [
        .target(
            name: "task3",
            dependencies: ["Alamofire"]),
      
    ]
)
