import XCTest
@testable import RickAndMorty_UIKit_MVVM

final class CharacterListViewModelTests: XCTestCase {
    var charactersAPIMock: CharactersAPIMock!
    
    var sut: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()

        charactersAPIMock = CharactersAPIMock()
        
        sut = CharacterListViewModel(
            dependencies: .init(api: charactersAPIMock)
        )
    }
    
    override func tearDown() {
        sut = nil
        charactersAPIMock = nil
        
        super.tearDown()
    }
    
    func test_when_fetchCharactersWasNotCalled_then_viewStateIsInitial() {
        XCTAssertEqual(sut.viewState, CharacterListViewModel.ViewState.initial)
    }
    
    func test_when_fetchCharactersReturnsEmpty_then_viewStateIsEmpty() {
        let expectedResult: CharacterListViewModel.ViewState = .empty(
            state: .init(title: "No characters found",
                         subtitle: "Please try again later",
                         image: "ram-empty",
                         buttonTitle: "Refresh")
            )
            
        charactersAPIMock.charactersResult = [Character]()
        
        sut.fetchCharacters()
        
        XCTAssertEqual(sut.viewState, expectedResult)
    }
    
    func test_when_fetchCharactersReturnsData_then_viewStateIsLoaded() {
        let expectedResult: CharacterListViewModel.ViewState = .loaded(items: [
            .init(
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                lastKnownLocation: "Earth",
                firstSeenLocation: "Earth")
        ])
        
        
        charactersAPIMock.charactersResult = [CharacterTestData.character]
        
        sut.fetchCharacters()
        
        XCTAssertEqual(sut.viewState, expectedResult)
    }
    
    func test_when_fetchCharactersReturnsError_then_viewStateIsError() {
        let expectedResult: CharacterListViewModel.ViewState = .error(state: CharacterListViewModel.ErrorViewState(
            title: "Error, error!",
            subtitle: "Something went really wrong",
            image: "ram-error",
            buttonTitle: "AAArgghhh")
        )
        
        charactersAPIMock.charactersError = .invalidURL
        
        sut.fetchCharacters()
        
        XCTAssertEqual(sut.viewState, expectedResult)
    }
    
    func test_when_fetchCharactersIsCalled_then_viewStateIsLoading() {
        let expectedResult: CharacterListViewModel.ViewState = .loading(state: .init(
            title: "Loading",
            subtitle: "More, More load MORE!!!",
            image: "ram-initial",
            buttonTitle: "Refresh")
        )
        
        charactersAPIMock.shouldExecuteOnCompletion = false
        sut.fetchCharacters()
        
        XCTAssertEqual(sut.viewState, expectedResult)
    }
    
}
