import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Zewo/Router.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/Epoch.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/PostgreSQL.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/Sideburns.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 4),
    ]
)
