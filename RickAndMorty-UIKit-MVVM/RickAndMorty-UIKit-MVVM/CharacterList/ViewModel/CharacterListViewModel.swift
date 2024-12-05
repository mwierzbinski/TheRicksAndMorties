/* -
enum CharacterList {
	class ViewModel {
		
	}
	
	class ViewController {
		
	}
	
	class Cell {
		
	}
}
*/

protocol CharacterListViewModelProtocol: AnyObject {
    var viewState: CharacterListViewModel.ViewState { get }
    var delegate: CharacterListViewModelOutput? { set get }
    
    func fetchCharacters()
    func getCharacterModel(for index: Int) -> Character?
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
    
    struct Model {
        var characters: [Character]?
    }
    
    private let dependencies: Dependencies
    private var model: Model?
    
    weak var delegate: CharacterListViewModelOutput?
    
    var viewState: ViewState = .initial { // its done so we could have more states
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
	// should this be extension
    private func toViewState(with data: [Character]?, error: ClientAPI.Error?) -> ViewState { // decouple
			if error != nil {
				return .error(state: .default)
			}
			
			let items = data?.map(\.viewState) ?? []
			
			return items.isEmpty ? .empty(state: .empty) : .loaded(items: items)
		}
}

// Add Swiftlint
extension CharacterListViewModel: CharacterListViewModelProtocol {
    func fetchCharacters() { // naming - loadData
			viewState = .loading(state: .loading)
			dependencies.api.getCharacters { [weak self] data, error in
				if let viewState = self?.toViewState(with: data, error: error) {
					self?.model = .init(characters: data)
					self?.viewState = viewState
				} else {
					// Should we handle this situation?
				}
			}
		}
    
    func getCharacterModel(for index: Int) -> Character? {
        return model?.characters?[index]
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

private extension Character {
	var viewState: CharacterListViewModel.CharacterCellViewState {
		.init(
			image: image,
			name: name,
			status: status,
			species: species,
			lastKnownLocation: location.name,
			firstSeenLocation: origin.name
		)
	}
}

private extension CharacterListViewModel.ErrorViewState {
	static let `default`: CharacterListViewModel.ErrorViewState = .init(
			title: "Error",
			subtitle: "Something went wrong",
			image: "ram-error",
			buttonTitle: "Refresh"
		)
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
