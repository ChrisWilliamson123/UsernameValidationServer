import Embassy
import Foundation

typealias Request = [String: Any]

@main
public struct UsernameValidationServer {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(UsernameValidationServer().text)
        let loop = try! SelectorEventLoop(selector: try! KqueueSelector())
        let server = DefaultHTTPServer(eventLoop: loop, interface: "::1", port: 8000) { (request: Request, startResponse: ((String, [(String, String)]) -> Void), sendBody: ((Data) -> Void)) in
            defer { sendBody(Data()) }

            let processor = RemoteRequestProcessor()
            let result = processor.process(request)
            switch result {
            case .success(let data):
                startResponse("200 OK", [])
                sendBody(data)
            case .failure(let requestProcessingError):
                let code = requestProcessingError.errorCode
                startResponse("\(code) ERROR", [])
                if let message = requestProcessingError.errorDescription { sendBody(Data(message.utf8)) }
            }
        }

        try! server.start()

        loop.runForever()
    }
}
