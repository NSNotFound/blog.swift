import Core
import HTTP
import Middleware

extension PostController {

  func index(request: Request) -> Response {
    let json: JSON = ["posts": JSON.from(self.all.map(Post.toJSON))]
    return Response(status: .OK, json: json)
  }

  func create(request: Request) -> Response {
    guard let json = request.JSONBody, content = json["content"]?.stringValue else {
      return Response(status: .BadRequest)
    }
    let post = self.insert(content)
    return Response(status: .OK, json: post.toJSON())
  }

  func show(request: Request) -> Response {
    guard let id = request.parameters["id"], post = self[id] else {
      return Response(status: .NotFound)
    }
    return Response(status: .OK, json: post.toJSON())
  }

  func update(request: Request) -> Response {
    guard let id = request.parameters["id"] where self[id] != nil else {
      return Response(status: .NotFound)
    }
    guard let json = request.JSONBody,
      content = json["content"]?.stringValue,
      created = json["created"]?.stringValue else {
        return Response(status: .BadRequest)
      }
    self[id] = Post(id: id, content:content, created: created)
    return Response(status: .NoContent)
  }

  func destroy(request: Request) -> Response {
    guard let id = request.parameters["id"] where self[id] != nil else {
      return Response(status: .NotFound)
    }
    self[id] = nil
    return Response(status: .NoContent)
  }

}
