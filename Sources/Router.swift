import HTTP
import Router
import Middleware
import Sideburns

let router = Router { r in

  r.router("/api", APIv1)

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

  let staticFiles = FileResponder(basePath: "Static/")
  r.fallback(staticFiles)

}

