import Foundation
@testable import RickAndMorty_UIKit_MVVM

final class ErrorHandlerMock: ErrorHandlerProtocol {
    var loggedError: (any LogableError)?
    var logCalledCount: Int = 0
    
    func log(error: any LogableError) {
        logCalledCount += 1
        self.loggedError = error
    }
}
