import Foundation

protocol CharacterDetailViewModelProtocol: AnyObject {
    var viewState: CharacterListViewModel.ViewState { get }
    var delegate: CharacterDetailViewModelOutput? { set get }
}

protocol CharacterDetailViewModelOutput: AnyObject {
    
    func updateUI()
}

final class CharacterDetailViewModel {
    struct Dependencies {
    
    }
    
    struct Model {
        let character: Character
    }
    
    let model: Model
    
    weak var delegate: CharacterDetailViewModelOutput?
    
    var viewState: CharacterDetailViewState {
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(model: Model) {
        self.model = model
        self.viewState = .init(
            name: model.character.name,
            image: model.character.image,
            subtitle: model.character.location.name
        )
    }
}

struct CharacterDetailViewState: Equatable {
    let name: String
    let image: String
    let subtitle: String
}
