import HTTP
import Router
import Middleware
import Sideburns

let router = Router { r in

  r.router("/api", APIv1)

  r.get("/") { request in
    return Response(
      status: .OK,
      headers: [
        "Content-Type": "text/html; encoding=UTF8"
      ],
      filePath: "Static/index.htm")
  }

  let staticFiles = FileResponder(basePath: "Static/")
  r.fallback(staticFiles)

}

