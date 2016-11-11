import HTTPServer

let index = BasicResponder { request in
  let headers : Headers = [:]
  return try Response(status: .ok, headers: headers, filePath: "public/index.html")
}

let routes = [
  "/",
]

let router = BasicRouter(staticFilesPath: "public") { route in
  for path in routes {
    route.add(methods: [.get], path: path, responder: index)
  }
}

let contentNegotiation = ContentNegotiationMiddleware(mediaTypes: [.json])
let log = Logger()
let server = try Server(port: 8080, middleware: [log, contentNegotiation], responder: router)
try server.start()
