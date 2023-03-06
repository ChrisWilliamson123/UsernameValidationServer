import Foundation

final class RemoteRequestProcessor {
    func process(_ request: Request) -> Result<Data, RequestProcessingError> {
        guard let path = request.path else { return .failure(RequestProcessingError.missingPath) }
        guard path == "/validateUsername" else { return .failure(RequestProcessingError.invalidPath(path)) }

        return processValidateUsername(request)
    }

    private func processValidateUsername(_ request: Request) -> Result<Data, RequestProcessingError> {
        guard let data = request.input else { return .failure(RequestProcessingError.noDataProvided) }

        let decoder = JSONDecoder()
        do {
            let requestBody = try decoder.decode(UsernameValidationRequest.self, from: data)
            return .success(Data("Processed username: \(requestBody.username)".utf8))
        } catch {
            return .failure(RequestProcessingError.unexpectedBody(data: data, path: request.path!))
        }
    }
}

struct UsernameValidationRequest: Decodable {
    let username: String
}
