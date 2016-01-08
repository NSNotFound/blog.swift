struct Post {
  let id: String
  let content: String
  let created: String
}

extension Post: CustomStringConvertible {
  var description: String {
    return id + ": " + created
  }
}
