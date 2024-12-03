import XCTest
@testable import RickAndMorty_UIKit_MVVM

final class ClientAPITests: XCTestCase {
    
    var errorHandlerMock: ErrorHandlerMock!
    var sessionMock: RMURLSessionMock!
    
    var sut: ClientAPI!
    
    override func setUp() {
        super.setUp()
        
        errorHandlerMock = .init()
        sessionMock = .init()
        
        sut = ClientAPI(
            urlSession: sessionMock,
            errorHandler: errorHandlerMock
        )
    }
    
    override func tearDown() {
        sut = nil
        errorHandlerMock = nil
        sessionMock = nil
        
        super.tearDown()
    }
    
    func test_if_dataIsCorrupted_then_resultIsEmptyAndErrorIsLogged() {
        let expectation = XCTestExpectation(description: "")
        let expectedError: ClientAPI.Error = ClientAPI.Error.invalidJSON
        
        sessionMock.data = CharacterTestData.corruptedJson.data(using: .utf8)
        
        sut.getCharacters() { [weak self] result, error in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 1)
            XCTAssertEqual(
                expectedError.errorHandlerDescription(),
                self?.errorHandlerMock.loggedError?.errorHandlerDescription()
            )
            XCTAssertNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_if_dataIsCorrect_then_onCompletionWithDataIsCalled() {
        let expectation = XCTestExpectation(description: "")
        let expected: [Character] = [CharacterTestData.character]
        
        sessionMock.data = CharacterTestData.correctJason.data(using: .utf8)
        
        sut.getCharacters() { [weak self] result, error in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 0)
            XCTAssertEqual(expected, result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_if_dataIsEmpty_then_errorIsLogged() {
        let expectation = XCTestExpectation(description: "")
        let expectedError: ClientAPI.Error = ClientAPI.Error.invalidData
        
        sessionMock.data = nil
        
        sut.getCharacters() { [weak self] result, error in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 1)
            XCTAssertEqual(
                expectedError.errorHandlerDescription(),
                self?.errorHandlerMock.loggedError?.errorHandlerDescription()
            )
            XCTAssertNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
