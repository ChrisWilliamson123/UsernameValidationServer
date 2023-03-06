import XCTest
@testable import UsernameValidationServer

final class RemoteRequestProcessorTests: XCTestCase {
    func testProcess_givenRequestWithNoPath_returnsFailureWithMissingPathError() throws {
        let request = Request()
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .failure(.missingPath))
    }

    func testProcess_givenInvalidPath_returnsFailureWithInvalidPathError() throws {
        var request = Request()
        request.path = "invalidPath"
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .failure(.invalidPath("invalidPath")))
    }

    func testProcess_givenValidateUsernamePath_returnsSuccessWithExpectedData() throws {
        var request = Request()
        request.path = "/validateUsername"
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .success(Data("Processed username validation".utf8)))
    }
}
