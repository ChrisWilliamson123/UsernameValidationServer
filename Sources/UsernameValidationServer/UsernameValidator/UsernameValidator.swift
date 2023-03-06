enum UsernameValidationError: Error, Equatable {
    case tooShort
    case tooLong
}

struct UsernameValidator {
    private static let MINIMUM_LENGTH = 4
    private static let MAXIMUM_LENGTH = 20


    func validate(_ username: String) throws {
        let length = username.count
        if length < Self.MINIMUM_LENGTH { throw UsernameValidationError.tooShort }
        if length > Self.MAXIMUM_LENGTH { throw UsernameValidationError.tooLong }
    }
}
