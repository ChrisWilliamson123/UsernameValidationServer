import Foundation

enum RequestProcessingError: LocalizedError, Equatable {
    case invalidPath(String)
    case missingPath
    case noDataProvided
    case unexpectedBody(data: Data, path: String)

    var errorDescription: String? {
        switch self {
        case .invalidPath(let path):
            return "Path not supported: \(path)"
        case .missingPath:
            return "Request is missing path"
        case .noDataProvided:
            return "No data provided with request"
        case .unexpectedBody(let data, let path):
            return "Unexpected body for \(path): \(String(data: data, encoding: .utf8) ?? "")"
        }
    }

    var errorCode: Int {
        switch self {
        case .invalidPath: return 404
        case .missingPath, .noDataProvided, .unexpectedBody: return 400
        }
    }
}
