import Core

extension Post {
  func toJSON() -> JSON {
    return [
      "id": JSON.from(id),
      "content": JSON.from(content),
      "created": JSON.from(created)
    ]
  }

  static func toJSON(post: Post) -> JSON {
    return post.toJSON()
  }
}
