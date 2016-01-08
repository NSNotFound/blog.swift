import PostgreSQL
import Foundation

let postController = try! PostController()

final class PostController {

  private var dataCache = [Post]()

  init() throws {
    try c.open()
    dataCache = all
  }

  deinit {
    c.close()
  }

  func insert(content: String) -> Post {
    let sql = "INSERT INTO posts(created, content) VALUES(now(), '\(content)') RETURNING id"
    let result = try! c.execute(sql)
    let id = result[0]["id"]!.string!
    let created = result[0]["created"]!.string!
    let post = Post(id: id, content: content, created: created)
    dataCache.append(post)
    return post
  }

  var all: [Post] {
    if dataCache.count != 0 {
      return dataCache
    }
    let result = try! c.execute("SELECT * FROM posts ORDER BY id")
    let posts = result.map { row in
      return Post(
        id: row["id"]!.string!,
        content: row["content"]!.string!,
        created: row["created"]!.string!
      )
    }
    dataCache = posts
    return posts
  }

  subscript(id: String) -> Post? {
    get {
      if dataCache.count != 0 {
        return dataCache.filter({ $0.id == id }).first
      }
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
      dataCache.removeAll()
      if all.count > 0 {
        // Do nothing just reload from db.
      }
    }
  }

}

