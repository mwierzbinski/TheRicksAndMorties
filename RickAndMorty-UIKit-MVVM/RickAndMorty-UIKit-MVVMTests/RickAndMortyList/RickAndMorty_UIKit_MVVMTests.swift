import XCTest
@testable import RickAndMorty_UIKit_MVVM

final class RickAndMortyAPITests: XCTestCase {
    
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
        let expectation = XCTestExpectation(description: "getCharacters called")
        let expected: [Character] = []
        let expectedError: ClientAPI.Error = ClientAPI.Error.invalidJSON
        
        sessionMock.data = CharacterTestData.corruptedJson.data(using: .utf8)
        
        sut.getCharacters() { [weak self] result in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 1)
            XCTAssertEqual(
                expectedError.errorHandlerDescription(),
                self?.errorHandlerMock.loggedError?.errorHandlerDescription()
            )
            XCTAssertEqual(expected, result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_if_dataIsCorrect_then_onCompletionWithDataIsCalled() {
        let expectation = XCTestExpectation(description: "getCharacters called")
        let expected: [Character] = [CharacterTestData.character]
        
        sessionMock.data = CharacterTestData.correctJason.data(using: .utf8)
        
        sut.getCharacters() { [weak self] result in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 0)
            XCTAssertEqual(expected, result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_if_dataIsEmpty_then_errorIsLogged() {
        let expectation = XCTestExpectation(description: "getCharacters called")
        let expected: [Character] = []
        let expectedError: ClientAPI.Error = ClientAPI.Error.invalidData
        
        sessionMock.data = nil
        
        sut.getCharacters() { [weak self] result in
            XCTAssertTrue(self?.errorHandlerMock.logCalledCount == 1)
            XCTAssertEqual(
                expectedError.errorHandlerDescription(),
                self?.errorHandlerMock.loggedError?.errorHandlerDescription()
            )
            XCTAssertEqual(expected, result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

enum CharacterTestData {
    static let character: Character = .init(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
        location: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
          ],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    )
    
    static let corruptedJson: String = "This is totally corrupted Json"
    
    static let correctJason: String = """
{
  "info": {
    "count": 826,
    "pages": 42,
    "next": "https://rickandmortyapi.com/api/character/?page=2",
    "prev": null
  },
  "results": [
    {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "type": "",
      "gender": "Male",
      "origin": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/1"
      },
      "location": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/20"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "episode": [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2",
      ],
      "url": "https://rickandmortyapi.com/api/character/1",
      "created": "2017-11-04T18:48:46.250Z"
    }
  ]
}
"""
}
