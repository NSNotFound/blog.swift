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

  let server = Server(port: port, responder: router)
  server.start()
}

main.run()

