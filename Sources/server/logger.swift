import Foundation
import Axis
import HTTP

extension Request {
  public var requestId: String? {
        get {
            return headers["X-Request-Id"]
        }

        set(id) {
            headers["X-Request-Id"] = id
        }
    }
}

public struct Logger : Middleware {
  private let stream: Axis.OutputStream?
  private let timeout: Double

  public init(stream: Axis.OutputStream? = nil, timeout: Double = 30.seconds) {
    self.stream = stream
    self.timeout = timeout
  }

  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var r = request
    let id = UUID().uuidString
    r.requestId = id
    let t = NSDate.timeIntervalSinceReferenceDate
    var message: String = "r=\(id) method=\(request.method) url=\"\(request.url)\""
    do {
      let response = try next.respond(to: request)
      let t2 = (NSDate.timeIntervalSinceReferenceDate - t) * 1000
      message += " t=\(String(format: "%.00f", t2))ms"
      try log(message)
      return response
    } catch {
      let t2 = (NSDate.timeIntervalSinceReferenceDate - t) * 1000
      message += " error=\"\(error)\" t=\(String(format: "%.00f", t2))ms"
      try log(message)
      return try Response(status: .internalServerError, headers: Headers(), filePath: "public/500.html")
    }
  }

  func log(_ message: String) throws {
    if let stream = self.stream {
      try stream.write(message, deadline: timeout.fromNow())
    } else {
      print(message)
    }
  }
}
