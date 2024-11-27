
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
    
    weak var delegate: CharacterListViewModelOutput? {
        didSet {
            initializeViewState()
        }
    }
    
    var viewState: ViewState = .initial {
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(dependencies: Dependencies = .init()) {
		self.dependencies = dependencies
	}

    func initializeViewState() {
        // In this case its not needed,
        // but we want to set ViewState here
        // with any data that was passed to viewModel
        viewState = .initial
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    func fetchCharacters() {
        dependencies.api.getCharacters { [weak self] data, error  in
            guard let data else { return }
            
            print("Received data \(data)")
            self?.viewState = .init(items: data)
        }
    }
}

extension CharacterListViewModel {
    struct ViewState {
        var items: [Character]
        
        static let initial: ViewState = .init(items: [])
    }
}
