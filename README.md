# blog.swift

My first tiny server-side Swift blog app.
Built with [Epoch](https://github.com/Zewo/Epoch)
by [Zewo](https://github.com/Zewo).

__[WIP] DO NOT USE__
Please checkout the
[TODO list](https://github.com/NSNotFound/blog.swift/issues/3)



## Requirements

- [PostgreSQL](https://github.com/NSNotFound/blog.swift/blob/master/Postgres%20Installation.md)
- [Swift 2.2](https://swift.org/download/#apple-platforms)
- [pip](https://pip.pypa.io/en/stable/installing/#install-pip)

##### OS X 10.11 (El Capitan)
- [Homebrew](http://brew.sh)

##### Ubuntu 14.04
- [apt-get](https://help.ubuntu.com/community/AptGet/Howto)


## Usage

1. Install Swift 2.2
2. `make bootstrap`
3. `make initdb`
4. `make build`
5. `make start`
6. Open http://localhost:4000
7. Press `Ctrl+c` to stop the server
8. `make watch` and change any Swift code...



## LICENSE

blog.swift is released under the MIT license. See LICENSE for details.
