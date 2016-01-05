#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

import HTTP
import Router
import Epoch
import CHTTPParser
import CLibvenice
import Commander
import PostgreSQL
import Sideburns

var c: Connection

let r = Router { r in

  r.get("/") { request in
    do {
      let result = try c.execute("SELECT * FROM posts LIMIT 100;")
      var posts = result.map { [
          "id": String($0["id"]!.integer!),
          "created": $0["created"]!.string,
          "content": $0["content"]!.string,
      ]}
      return try Response(
        status: .OK,
        templatePath: "./Templates/index.mustache",
        templateData: ["posts": posts])
    } catch {
      print("\(error)")
      return Response(status: .InternalServerError)
    }
  }

  r.get("/posts/:id") { request in
    let id = request.parameters["id"]
    // TODO: load post
    return Response(status: .OK)
  }

  r.get("/static/main.css") { request in
    return Response(status: .OK, filePath: "./Static/main.css")
  }

}

let main = command(
  Option("port", 3000, description: "The TCP port of web server."),
  Option("dbuser", "postgres", description: "PostgreSQL db user."),
  Option("dbpassword", "", description: "PostgreSQL db password."),
  Option("dbserver", "127.0.0.1", description: "PostgreSQL server address."),
  Option("dbname", "blog", description: "PostgreSQL database name.")
) { port, user, passwd, db, dbname in

  let dbscheme = "postgresql://\(user):\(passwd)@\(db)/\(dbname)"
  let info = Connection.Info(connectionString: dbscheme)
  c = Connection(info)
  do {
    try c.open()
  } catch {
    print(error)
  }

  let server = Server(port: port, responder: r)
  server.start()
}

main.run()

