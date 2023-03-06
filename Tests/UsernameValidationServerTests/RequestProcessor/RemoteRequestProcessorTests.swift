import XCTest
@testable import UsernameValidationServer

final class RemoteRequestProcessorTests: XCTestCase {
    // MARK: Error paths
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

    func testProcess_givenValidateUsernamePathWithoutData_returnsNoDataError() throws {
        var request = Request()
        request.path = "/validateUsername"
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .failure(.noDataProvided))
    }

    func testProcess_givenValidateUsernamePathWithInvalidData_returnsUnexpectedBodyError() throws {
        var request = Request()
        request.path = "/validateUsername"
        request.input = Data("{\"hello\":\"world\"}".utf8)
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .failure(.unexpectedBody(data: Data("{\"hello\":\"world\"}".utf8), path: "/validateUsername")))
    }

    // MARK: Happy paths
    func testProcess_givenValidateUsernamePathWithValidData_returnsSuccessWithExpectedData() throws {
        var request = Request()
        request.path = "/validateUsername"
        request.input = Data("{\"username\":\"cjwilliamson\"}".utf8)
        let processor = RemoteRequestProcessor()
        let result = processor.process(request)
        XCTAssertEqual(result, .success(Data("Processed username: cjwilliamson".utf8)))
    }
}
