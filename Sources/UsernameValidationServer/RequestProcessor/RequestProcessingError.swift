import Foundation

enum RequestProcessingError: LocalizedError, Equatable {
    case invalidPath(String)
    case missingPath

    var errorDescription: String? {
        switch self {
        case .invalidPath(let path): return "Path not supported: \(path)"
        case .missingPath:           return "Request is missing path"
        }
    }

    var errorCode: Int {
        switch self {
        case .invalidPath: return 404
        case .missingPath: return 400
        }
    }
}
