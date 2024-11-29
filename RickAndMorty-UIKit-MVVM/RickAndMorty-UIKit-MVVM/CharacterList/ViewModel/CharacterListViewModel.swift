
// ask - enum RickAndMortyList { }

protocol CharacterListViewModelProtocol: AnyObject {
    var viewState: CharacterListViewModel.ViewState { get }
    var delegate: CharacterListViewModelOutput? { set get }
    
    func fetchCharacters()
}

protocol CharacterListViewModelOutput: AnyObject {
    
    func updateUI()
}

class CharacterListViewModel {
    
    struct Dependencies {
        let api: CharactersAPIProtocol
        
        init(api: CharactersAPIProtocol = ClientAPI()) {
            self.api = api
        }
    }
	
    private let dependencies: Dependencies
    
    weak var delegate: CharacterListViewModelOutput?
    
    var viewState: ViewState = .initial {
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(dependencies: Dependencies = .init()) {
		self.dependencies = dependencies
	}
    
    private func viewState(from data: [Character]) -> ViewState {
        .init(items: data.map { CharacterCellViewState.init(image: $0.image,
                                                            name: $0.name,
                                                            status: $0.status,
                                                            species: $0.species,
                                                            lastKnownLocation: $0.location.name,
                                                            firstSeenLocation: $0.origin.name)
        })
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    func fetchCharacters() {
        dependencies.api.getCharacters { [weak self] data, error  in
            guard
                let data,
                let state = self?.viewState(from: data)
            else { return }
            self?.viewState = state
        }
    }
}

extension CharacterListViewModel {
    struct ViewState {
        var items: [CharacterCellViewState]
        
        static let initial: ViewState = .init(items: [])
    }
    
    struct CharacterCellViewState {
        let image: String
        let name: String
        let status: String
        let species: String
        let lastKnownLocation: String
        let firstSeenLocation: String
    }
}
