import Foundation

final class RemoteRequestProcessor {
    func process(_ request: Request) -> Result<Data, RequestProcessingError> {
        guard let path = request.path else { return .failure(RequestProcessingError.missingPath) }
        guard path == "/validateUsername" else { return .failure(RequestProcessingError.invalidPath(path)) }
        return .success(Data("Processed username validation".utf8))
    }
}
