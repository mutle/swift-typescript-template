import Foundation
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
    let response = try next.respond(to: request)
    let t2 = (NSDate.timeIntervalSinceReferenceDate - t) * 1000
    var message: String = ""
    message += "r=\(id) method=\(request.method) url=\(request.url) t=\(String(format: "%.00f", t2))ms"

    if let stream = stream {
      try stream.write(message, deadline: timeout.fromNow())
    } else {
      print(message)
    }

    return response
  }
}
