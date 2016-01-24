import HTTP
import Router
import Middleware

let APIv1 = Router("/v1") { r in
  r.get("/version") { _ in
    return Response(status: .OK, json: ["version": "1.0.0"])
  }

  r.get("/posts", postController.index)
  r.post("/posts", parseJSON >>> postController.create)
  r.get("/posts/:id", postController.show)
  r.put("/posts/:id", parseJSON >>> postController.update)
  r.delete("/posts/:id", postController.destroy)

  r.post("/users/login", parseJSON >>> userController.login)
}
