// ask - enum RickAndMortyList { }

/*
 [ ] Dodac detailsView
 */

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
    
    var viewState: ViewState = .initial { // its done so we could have more states
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
    private func toViewState(with data: [Character]?, error: ClientAPI.Error?) -> ViewState {
        if error != nil {
            // Depending on Errors this can even be a factory to create a proper message for each error
            return .error(state: ErrorViewState(title: "Error, error!", subtitle: "Something went really wrong", image: "ram-error", buttonTitle: "AAArgghhh" ))
        }
        
        if let data {
            let items = data.map { CharacterCellViewState.init(image: $0.image,
                                                               name: $0.name,
                                                               status: $0.status,
                                                               species: $0.species,
                                                               lastKnownLocation: $0.location.name,
                                                               firstSeenLocation: $0.origin.name)
            }
            
            if !items.isEmpty {
                return .loaded(items: items)
            }
        }
        
        return .empty(state: .empty)
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    func fetchCharacters() {
        viewState = .loading(state: .loading)
        dependencies.api.getCharacters { [weak self] data, error  in
            if let viewState = self?.toViewState(with: data, error: error) {
                self?.viewState = viewState
            } else {
                // Should we handle this situation?
            }
        }
    }
}

extension CharacterListViewModel {
    enum ViewState: Equatable {
        case initial
        case loading(state: EmptyViewState)
        case loaded(items: [CharacterCellViewState])
        case error(state: ErrorViewState)
        case empty(state: EmptyViewState)
    }
    
    struct EmptyViewState: Equatable {
        let title: String
        let subtitle: String
        let image: String
        let buttonTitle: String
    }
    
    struct ErrorViewState: Equatable {
        let title: String
        let subtitle: String
        let image: String
        let buttonTitle: String
    }
    
    struct CharacterCellViewState: Equatable {
        let image: String
        let name: String
        let status: String
        let species: String
        let lastKnownLocation: String
        let firstSeenLocation: String
    }
}

extension CharacterListViewModel.ViewState {
    var charactersCount: Int {
        switch self {
        case .initial, .loading, .error, .empty: return 0
        case let .loaded(items): return items.count
        }
    }
    
    var characters: [CharacterListViewModel.CharacterCellViewState] {
        switch self {
        case .initial, .loading, .error, .empty: return []
        case let .loaded(items): return items
        }
    }
}

private extension CharacterListViewModel.EmptyViewState {
    static let empty: CharacterListViewModel.EmptyViewState = .init(
        title: "No characters found",
        subtitle: "Please try again later",
        image: "ram-empty",
        buttonTitle: "Refresh"
    )
    
    static let loading: CharacterListViewModel.EmptyViewState = .init(
        title: "Loading",
        subtitle: "More, More load MORE!!!",
        image: "ram-initial",
        buttonTitle: "Refresh"
    )
}
