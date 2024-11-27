import Foundation
@testable import RickAndMorty_UIKit_MVVM

final class RMURLSessionMock: RMURLSession {
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock(
            data: data,
            completionHandler: completionHandler,
            mockError: error
        )
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask, @unchecked Sendable {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var mockData: Data?
    var completionHandler: CompletionHandler?
    var mockError: Error?
    
    override func resume() {
        completionHandler?(mockData, response, mockError)
    }
    
    init(data: Data? = nil, completionHandler: CompletionHandler? = nil, mockError: Error? = nil) {
        self.mockData = data
        self.completionHandler = completionHandler
    }
}
