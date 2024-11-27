import Foundation

protocol ErrorHandlerProtocol {
    func log(error: any LogableError)
}

protocol LogableError: Error, Equatable {
    func errorHandlerDescription() -> String
}

struct ErrorHandler: ErrorHandlerProtocol {
    func log(error: any LogableError) {
        print("⚠️ Error: \(error.errorHandlerDescription())")
    }
}
