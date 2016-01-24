import PostgreSQL
import Foundation
import Core
import HTTP

let userController = try! UserController()

final class UserController {

  init() throws {
    try c.open()
  }
  
  deinit {
    c.close()
  }
  
  typealias AccessToken = String

  private func login(username: String, _ password: String) -> AccessToken? {
    let sql = "SELECT * FROM users WHERE username = '$1' and password = digest('$2', 'sha1') RETURNING id;"
    let result = try! c.execute(sql, parameters: [username, password])
    if let _ = result.first {
      // TODO: Generate and save new access_token
      return ""
    } else {
      return nil
    }
  }

  func login(request: Request) -> Response {
    guard let json = request.JSONBody else {
      return Response(status: .BadRequest)
    }
    if let username = json["username"]?.stringValue, password = json["password"]?.stringValue {
      if let accessToken = login(username, password) {
        let accessTokenJSON: JSON = [
          "accessToken": JSON.from(accessToken)
        ]
        return Response(status: .OK, json: accessTokenJSON)
      }
    }
    return Response(status: .Forbidden)
  }
}
