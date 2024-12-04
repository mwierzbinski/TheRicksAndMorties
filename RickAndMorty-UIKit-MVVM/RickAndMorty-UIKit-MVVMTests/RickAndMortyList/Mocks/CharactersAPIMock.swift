import XCTest
@testable import RickAndMorty_UIKit_MVVM

final class CharactersAPIMock: CharactersAPIProtocol {
    
    var charactersCalled: Bool = false
    var charactersError: ClientAPI.Error? = nil
    var charactersResult: [Character]?
    var shouldExecuteOnCompletion: Bool = true
    
    func getCharacters(onCompletion: @escaping CompletionHandler) {
        charactersCalled = true
        
        if shouldExecuteOnCompletion {
            onCompletion(charactersResult, charactersError)
        }
    }
}
