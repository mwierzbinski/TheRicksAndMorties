import UIKit

protocol CharacterViewFactoryProtocol {
	func makeCharacterView(with state: CharacterListViewModel.ViewState) -> UIView?
}

struct CharacterViewFactory: CharacterViewFactoryProtocol {
	func makeCharacterView(with state: CharacterListViewModel.ViewState) -> UIView? {
		switch state {
		case let .loading(state):
			return EmptyView(state: state)
		case let .empty(state):
			return EmptyView(state: state)
		case let .error(state):
			return ErrorView(state: state)
		case .loaded:
			return nil
		case .initial:
			return InitialView()
		}
	}
}
