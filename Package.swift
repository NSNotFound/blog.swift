import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Zewo/Epoch.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/Middleware.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/PostgreSQL.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/Sideburns.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 4),
        .Package(url: "https://github.com/Zewo/CURIParser.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/CLibvenice.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/CHTTPParser.git", majorVersion: 0, minor: 1)
    ]
)
