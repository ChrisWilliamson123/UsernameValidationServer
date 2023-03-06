import Foundation

protocol RequestProcessor {
    func process(_ request: Request) -> Result<Data, RequestProcessingError>
}
