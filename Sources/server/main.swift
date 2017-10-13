import Foundation
import web
import web_swift_server


var port: Int = 8080
if let p = ProcessInfo.processInfo.environment["SERVER_PORT"], let i = Int(p) { port = i }

let indexRoutes : [[Any]] = [
  ["/"],
]

let log = WebLoggerExtension()
let router = WebRouter()
router.addStaticFiles(root: "public")
for path in indexRoutes {
  if path.count == 1, let path = path.first as? String {
    router.route(path, file: "public/index.html")
  } else {
    router.route(path, file: "public/index.html")
  }
}

let server = WebServer(adapter: WebSwiftServerAdapter(), responder: router, extensions: [log], port: port)
try server.run()
