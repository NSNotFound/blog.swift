import PostgreSQL
import Foundation

let postController = try! PostController()

final class PostController {

  init() throws {
    try c.open()
  }

  deinit {
    c.close()
  }

  func insert(content: String) -> Post {
    let result = try! c.execute("INSERT INTO posts(created, content) VALUES(now(), '\(content)') RETURNING id")
    let id = result[0]["id"]!.string!
    let created = result[0]["created"]!.string!
    return Post(id: id, content: content, created: created)
  }

  var all: [Post] {
    let result = try! c.execute("SELECT * FROM posts ORDER BY id")
    return result.map { row in
      return Post(
        id: row["id"]!.string!,
        content: row["content"]!.string!,
        created: row["created"]!.string!
      )
    }
  }

  subscript(id: String) -> Post? {
    get {
      let result = try! c.execute("SELECT * FROM posts WHERE id = '\(id)'")
      if result.count > 0 {
        let row = result[0]
        return Post(
          id: row["id"]!.string!,
          content: row["content"]!.string!,
          created: row["created"]!.string!
        )
      }
      return nil
    }
    set {
      if let post = newValue {
        try! c.execute("UPDATE posts SET content = '\(post.content)' WHERE id = '\(id)'")
      } else {
        try! c.execute("DELETE from posts WHERE id = '\(id)'")
      }
    }
  }

}
