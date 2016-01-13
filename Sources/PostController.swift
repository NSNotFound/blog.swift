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
    // TODO: authentication
    let sql = "INSERT INTO posts(created, content) VALUES(now(), '$1') RETURNING id"
    let result = try! c.execute(sql, parameters: [content])
    let id = result[0]["id"]!.string!
    let created = result[0]["created"]!.string!
    let post = Post(id: id, content: content, created: created)
    dataCache.append(post)
    return post
  }

  var all: [Post] {
    // TODO: pagenation
    if dataCache.count != 0 {
      return dataCache
    }
    let result = try! c.execute("SELECT * FROM posts ORDER BY id DESC")
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
      let result = try! c.execute("SELECT * FROM posts WHERE id = '$1'", parameters: [id])
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
      // TODO: authentication
      if let post = newValue {
        try! c.execute(
          "UPDATE posts SET content = '$1' WHERE id = '$2'",
          parameters: [post.content, id]
          )
      } else {
        try! c.execute("DELETE from posts WHERE id = '$1'", parameters: [id])
      }
      dataCache.removeAll()
      if all.count > 0 {
        // Do nothing just reload from db.
      }
    }
  }

}

